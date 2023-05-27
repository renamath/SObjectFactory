@isTest
public class ContactFactory extends SObjectFactory {

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
		// Override fieldInterator to use LastName instead of Name
		super.setFieldInterator('LastName');
	}
}