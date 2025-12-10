import flash.external.ExternalInterface;
import flash.utils.getQualifiedClassName;

ExternalInterface.call("console.log","[#] SIZE => " + usSize);
ExternalInterface.call("console.log","[#] Type => " + usType);
ExternalInterface.call("console.log","[#] INT => " + this.BlockCount);

_loc2_.GetByte(param1,(4 - param1.position) % 4 % 4);

this.Data[_loc3_].readBuf(param1);