contract CheckOverUnder {
    function checkUnderFlow() public pure returns (uint8){
        uint8 z = 8;
        uint8 result = z-10;
        return result;
    }
    
    function checkOverFlow() public pure returns (uint8){
        uint8 z = 250;
        uint8 result = z+10;
        return result;
    }
}
