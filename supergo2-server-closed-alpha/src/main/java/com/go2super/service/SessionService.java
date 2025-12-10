package com.go2super.service;

import com.go2super.database.cache.AccountCache;
import com.go2super.database.entity.Account;
import com.go2super.database.entity.AccountSession;
import com.go2super.database.repository.AccountSessionRepository;
import com.go2super.socket.util.DateUtil;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class SessionService {

    private static SessionService resourcesService;

    @Autowired
    @Getter
    private AccountSessionRepository accountSessionRepository;

    @Getter private AccountCache accountCache;

    @Autowired
    public SessionService(AccountCache accountCache) {

        resourcesService = this;

        this.accountCache = accountCache;

    }

    public AccountSession registerAccountSession(Account account, String token) {

        List<AccountSession> sessions = accountSessionRepository.findByAccountId(account.getId().toString());

        for(AccountSession accountSession : sessions)
            accountSessionRepository.delete(accountSession);

        AccountSession accountSession = AccountSession.builder()
                .accountId(account.getId().toString())
                .token(token)
                .expired(false)
                .loginDate(new Date())
                .untilDate(DateUtil.now(31 * 86400)) // 31 days hardcoded
                .build();

        return accountSessionRepository.save(accountSession.reference(account));

    }

    public Optional<AccountSession> getActiveAccountSessionByToken(String token) {

        Optional<AccountSession> sessionOptional = accountSessionRepository.findByToken(token);

        if(!sessionOptional.isPresent())
            return Optional.empty();

        AccountSession accountSession = sessionOptional.get();
        Optional<Account> accountOptional = accountCache.findById(accountSession.getAccountId());

        if(new Date().getTime() > accountSession.getUntilDate().getTime() || accountSession.isExpired() || !accountOptional.isPresent()) {

            accountSessionRepository.delete(accountSession);
            return Optional.empty();

        }

        return Optional.of(accountSession.reference(accountOptional.get()));

    }

    public Optional<AccountSession> getActiveAccountSessionByAccountId(String accountId) {

        List<AccountSession> sessions = accountSessionRepository.findByAccountId(accountId);

        if(sessions.isEmpty())
            return Optional.empty();

        if(sessions.size() > 1) {
            for(int i = 1; i < sessions.size(); i++) {
                accountSessionRepository.delete(sessions.get(i));
            }
        }

        AccountSession accountSession = sessions.get(0);
        Optional<Account> accountOptional = accountCache.findById(accountSession.getAccountId());

        if(new Date().getTime() > accountSession.getUntilDate().getTime() || accountSession.isExpired() || !accountOptional.isPresent()) {

            accountSessionRepository.delete(accountSession);
            return Optional.empty();

        }

        return Optional.of(accountSession.reference(accountOptional.get()));

    }

    public Optional<AccountSession> removeActiveAccountSession(String token) {

        Optional<AccountSession> sessionOptional = accountSessionRepository.findByToken(token);

        if(!sessionOptional.isPresent())
            return Optional.empty();

        AccountSession accountSession = sessionOptional.get();
        accountSessionRepository.delete(sessionOptional.get());

        return Optional.of(accountSession);

    }

    public static SessionService getInstance() {
        return resourcesService;
    }

}
