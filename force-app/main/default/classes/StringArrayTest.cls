public class StringArrayTest{

    public static List<String> generateStringArray(Integer n)
    {
        List<String> returnList = new List<String>();
        for(integer i=0;i<n;i++)
        {
            returnList.add('Test '+i);
        }
        return returnList;
    }
}