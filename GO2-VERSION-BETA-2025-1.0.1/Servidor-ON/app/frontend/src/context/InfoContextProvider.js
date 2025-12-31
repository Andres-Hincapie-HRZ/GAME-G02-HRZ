import React, { useState } from 'react'
import { useEffect } from 'react'


import { ApiWithoutToken } from "../components/ApiWithoutToken";
const Context = React.createContext({})

export function InfoContextProvider({ children }) {

    const [onlinePlayers, setOnlinePlayers] = useState(0);
    const [patch, setPatch] = useState(0);
    const [coordinates, setCoordinates] = useState({});

    useEffect(() => {
        getLastPlanet();
        getCurrentPatch();
        getOnlinePlayeras();
    }, []);

    const getCurrentPatch = async () => {
        const response = await ApiWithoutToken("get", "metrics/patch");
        setPatch(response.data.data.patch);
    };
    const getLastPlanet = async () => {
        const response = await ApiWithoutToken("get", "metrics/last/planet");
        setCoordinates(response.data.data);
    };
    const getOnlinePlayeras = async () => {
        const response = await ApiWithoutToken("get", "metrics/online");
        setOnlinePlayers(response.data.data.online);
    };

    return <Context.Provider value={{
        onlinePlayers,
        patch,
        coordinates
    }}>
        {children}
    </Context.Provider>
}

export default Context