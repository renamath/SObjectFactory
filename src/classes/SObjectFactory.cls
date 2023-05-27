/**
 * @author Renato Matheus Simião
 * @version 1.0
 * @date 2018-06-08
 * @description Framework to provide functionality in test class
 */
public abstract class SObjectFactory {

	private Integer defaultBulkRecords = 20; // 20 is the minimum amount recommended by Salesforce
	private String fieldInterator = 'Name';
	private List<SObject> listSobjectFieldInterator; // if null use only FIELD_INTERATOR, else use Id of this list + FIELD_INTERATOR

	private SObject record {get;set;}
	private List<SObject> records {get;set;}

	public SObjectFactory(SObject pRecord) {

		this.record = pRecord;
	}

	public SObject getRecord() {

		return this.record;
	}

	public SObject cloneRecord() {

		return this.record.clone();
	}

	public SObject createRecord() {

		if (this.record.Id == null) {
			insert this.record;
			//System.debug('record='+JSON.serialize(this.record));
		}

		return this.record;
	}

	public List<SObject> getRecords() {

		if (this.records == null) {

			this.records = new List<SObject>();

			for (Integer i = 0; i < this.defaultBulkRecords; i++) {

				SObject recordCloned = this.record.clone();

				if (this.listSobjectFieldInterator == null)
					recordCloned.put(this.fieldInterator, this.record.get(this.fieldInterator) + ' ' +i);
				else recordCloned.put(this.fieldInterator, this.listSobjectFieldInterator.get(i).Id);

				this.records.add(recordCloned);
			}
		}

		return this.records;
	}

	public List<SObject> createRecords() {

		this.records = getRecords();

		if (!this.records.isEmpty() && this.records.get(0).Id == null)
			insert this.records;

		return this.records;
	}
}
