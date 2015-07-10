@isTest
private class CompositionControllerTest {

	@isTest static void testComposition_valid() {
		Test.startTest();

		Test.setCurrentPage(Page.HomePage);

		CompositionController controller = new CompositionController();
		controller.init();
		controller.doLogOut();

		Test.stopTest();
	}

}