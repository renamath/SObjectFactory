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
	public List<SObject> LIST_SOBJECT_FIELD_INTERATOR; // if null use only FIELD_INTERATOR, else use Id of this list + FIELD_INTERATOR
	
	private SObject record {get;set;}
	private List<SObject> lRecord {get;set;}

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

		if (record.Id == null) {
			insert record;
			//System.debug('record='+JSON.serialize(record));
		}

		return record;
	}

	public List<SObject> getRecords() {

		if (lRecord == null) {

			lRecord = new List<SObject>();

			for (Integer i = 0; i < DEFAULT_BULK_RECORDS; i++) {

				SObject recordCloned = record.clone();
			
				if (LIST_SOBJECT_FIELD_INTERATOR == null)
					recordCloned.put(FIELD_INTERATOR, record.get(FIELD_INTERATOR) + ' ' +i);
				else recordCloned.put(FIELD_INTERATOR, LIST_SOBJECT_FIELD_INTERATOR.get(i).Id);

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
