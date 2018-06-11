/**
 * @author Renato Matheus Simião
 * @company Art of Design
 * @version 1.0
 * @date 2018-06-08
 * @description Framework to provide functionality in test class
 */
public abstract class AOD_SObjectFactory {

	public Integer DEFAULT_BULK_RECORDS = 20; // 20 is the minimum amount recommended by Salesforce
	public String FIELD_INTERATOR = 'Name';
	
	protected SObject record {get;set;}
	protected List<SObject> lRecord {get;set;}

	public AOD_SObjectFactory(SObject pRecord) {
		
		record = pRecord;
	}

	public SObject getRecord() {

		return record;
	}

	public SObject cloneRecord() {

		return record.clone();
	}

	public SObject createRecord() {

		if (record.Id == null)
			insert record;

		return record;
	}

	public List<SObject> getRecords() {

		if (lRecord == null) {

			lRecord = new List<SObject>();

			for (Integer i = 1; i <= DEFAULT_BULK_RECORDS; i++) {

				SObject recordCloned = record.clone();
				recordCloned.put(FIELD_INTERATOR, record.get(FIELD_INTERATOR) + ' ' +i);
				lRecord.add(recordCloned);
			}
		}

		return lRecord;
	}

	public List<SObject> createRecords() {

		lRecord = getRecords();
		
		if (!lRecord.isEmpty() && lRecord.get(0).Id == null)
			insert lRecord;
		
		return lRecord;
	}
}