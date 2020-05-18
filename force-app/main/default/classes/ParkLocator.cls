Public class ParkLocator
{
    Public static List<String> country(String countryName)
    {
        List<String> parkDetails = new List<String>();
        ParkService.ParksImplPort pap = new ParkService.ParksImplPort();
        
        parkDetails = pap.byCountry(countryName);
        
        return parkDetails;
    }
}