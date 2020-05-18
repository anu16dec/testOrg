@isTest
Public class AnimalLocatorTest{

    @isTest static void AnimalLocatorTestMethod()
    {
        test.setMock(HTTPCalloutMock.class,new AnimalLocatorMock());
        String animalName = AnimalLocator.getAnimalNameById(2);
        system.assertEquals(animalName,'bear');
    }
}