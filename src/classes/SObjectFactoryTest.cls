/*
 * This class is not required if all methods of the SObjectFactory class are used
 */
@isTest
private class SObjectFactoryTest {

	@isTest
	static void testUnit() {

		TestFactory factory = new TestFactory();

		System.assert(factory.getRecord() != null);

		try {
			factory.createRecord();
		} catch (Exception e) {
			System.assertEquals('System.DmlException', e.getTypeName());
		}

		try {
			factory.cloneRecord();
		} catch (Exception e) {
			System.assertEquals('System.DmlException', e.getTypeName());
		}

		try {
			factory.createRecords();
		} catch (Exception e) {
			System.assertEquals('System.SObjectException', e.getTypeName());
		}
	}

	public class TestFactory extends SObjectFactory {

		public TestFactory() {

			super(Schema.getGlobalDescribe().get('Contact').newSObject());
		}
	}
}