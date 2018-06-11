@isTest
private class AOD_FactoryExampleTest {
	
	@isTest
	static void testUnitCreateAccount() {

		Account acc = (Account) new AccountFactory().createRecord();

		System.assertEquals('TestAccount', acc.Name);
	}

	@isTest
	static void testUnitCreateContactWithDefaultValues() {
		
		// Insert Account with default values before insert Contact
		Contact con = (Contact) new ContactFactory().createRecord();

		System.assertEquals('TestLastName', con.LastName);
		System.assertEquals('TestAccount', con.Account.Name);

		Contact con2 = (Contact) new ContactFactory().createRecord();

		// Is the same because the constructor ContactFactory() utilize a static record
		System.assertEquals('TestLastName', con2.LastName);
		System.assertEquals('TestAccount', con2.Account.Name);
	}

	@isTest
	static void testUnitCreateContactWithoutDefaultValues() {
		
		Account acc = (Account) new AccountFactory().getRecord();
		acc.Name = 'MyAccountName';
		insert acc;

		Contact con = (Contact) new ContactFactory(acc).createRecord();

		System.assertEquals('TestLastName', con.LastName);
		System.assertEquals('MyAccountName', con.Account.Name);

		// other codes ...
		// other codes ...
		// other codes ...

		Account acc2 = (Account) new AccountFactory().createRecord(); // OR getRecord();
		System.assertEquals('MyAccountName', acc2.Name);
		// MyAccountName because AccountFactory().createRecord() return the same static record
		
		Contact con2 = (Contact) new ContactFactory(acc2).createRecord();
		System.assertEquals('TestLastName', con2.LastName);
		System.assertEquals('MyAccountName', con2.Account.Name);
	}

	@isTest
	static void testUnitCreateAccountAfterContact() {

		Contact con = (Contact) new ContactFactory().createRecord();

		System.assertEquals('TestLastName', con.LastName);
		System.assertEquals('TestAccount', con.Account.Name);

		//---------------------------- WRONG ----------------------------------
		Account acc = (Account) new AccountFactory().getRecord();
		acc.Name = 'MyAccountName';
		
		try {
			insert acc;
		} catch (Exception e) {
			System.assert(e.getMessage().contains('cannot specify Id in an insert call: [Id]'));
			// because acc is alright inserted in the first line: ContactFactory().createRecord()
		}
		//------------------------------------------------------------------------
		
		//---------------------------- CORRECT ----------------------------------
		Account acc2 = (Account) new AccountFactory().cloneRecord();
		acc2.Name = 'MyAccountName';
		insert acc2;
		
		System.assertEquals('MyAccountName', acc2.Name);
		// true because AccountFactory().cloneRecord() return a clone of the static record
		//------------------------------------------------------------------------
		
		Contact con2 = (Contact) new ContactFactory(acc2).createRecord();

		System.assertEquals('TestLastName', con2.LastName);
		System.assertEquals('MyAccountName', con2.Account.Name);
	}

	@isTest
	static void testBulkCreateAccount() {

		List<Account> lAccount = (List<Account>) new AccountFactory().createRecords();

		System.assertEquals(20, [SELECT COUNT() FROM Account]);

		List<Account> lAccount2 = (List<Account>) new AccountFactory().createRecords();

		System.assertEquals(40, [SELECT COUNT() FROM Account]);
		// return 40 because AccountFactory().createRecords() do not control a list of record in static scope
		// as is done in AccountFactory().createRecord()
	}

	@isTest
	static void testBulkCreateContact() {

		ContactFactory factory = new ContactFactory();
		// Override the attribute DEFAULT_BULK_RECORDS to create only 10 record instead 20
		factory.DEFAULT_BULK_RECORDS = 10;

		List<Contact> lContact = (List<Contact>) factory.createRecords();

		System.assertEquals(10, [SELECT COUNT() FROM Contact]);
	}
}