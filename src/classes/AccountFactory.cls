@isTest
public class AccountFactory extends AOD_SObjectFactory {

	private static Account staticRecord;

	private static Account getRecordStatic() {

		if (staticRecord == null) {
			staticRecord = new Account(
				Name = 'TestAccount'
			);
		}

		return staticRecord;
	}

	public AccountFactory() {
		
		super(getRecordStatic());
	}

	/* If you do not want to be doing casting in your test class, uncomment the code below
	
	//now use createAccount intead createRecord
	public Account createAccount() {

		return (Account) super.createRecord();
	}
	//now use getAccount intead getRecord
	public Account getAccount() {

		return (Account) super.getRecord();
	}
	//... continue for other methods ...
	*/

}