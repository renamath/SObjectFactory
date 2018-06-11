@isTest
public class ContactFactory extends AOD_SObjectFactory {

	private static Contact staticRecord;

	private static Contact getRecordStatic(Account pAccount) {

		if (staticRecord == null) {
			staticRecord = new Contact(
				LastName = 'TestLastName',
				Account = pAccount,
				AccountId = pAccount.Id
			);
		}

		return staticRecord;
	}
	
	public ContactFactory() {

		// Call the constructor with parameter Account
		this((Account) new AccountFactory().createRecord());
	}

	public ContactFactory(Account pAccount) {

		super(getRecordStatic(pAccount));
		// Override FIELD_INTERATOR to use LastName instead Name
		super.FIELD_INTERATOR = 'LastName';
	}
}