package kr.wikibook;

import java.util.Locale;

import android.app.Activity;
import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteQueryBuilder;
import android.os.Bundle;
import android.util.Log;

public class ActivityMain extends Activity {
    /** Called when the activity is first created. */
	private SQLiteDatabase mDB;
	
	private static final String DB_NAME = "SQLiteAPITest.db";
	private static final String TAG = "SQLiteAPI";
	
	// private static final String DROP_TABLE_BOOKINFO = "DROP TABLE IF EXISTS tblBookInfo";
	// private static final String DROP_TABLE_PUBLISHERINFO = "DROP TABLE IF EXISTS tblPublisherInfo;";
	
	private static final String CREATE_TABLE_PUBLISHERINFO = "CREATE TABLE IF NOT EXISTS tblPublisherInfo(" +
																"publisher_id INTEGER PRIMARY KEY AUTOINCREMENT, "+
																"name TEXT);";

	
	private static final String CREATE_TABLE_BOOKINFO = "CREATE TABLE IF NOT EXISTS tblBookInfo(" +
															"isbn INTEGER PRIMARY KEY, " +
															"title TEXT," +
															"price INTEGER," +
															"publisher_id INTEGER," +
															"CONSTRAINT ctPublisherID_fk FOREIGN KEY(publisher_id) " +
															"REFERENCES tblPublisherInfo(publisher_id));";

	private static final String INSERT_SQLITE3 = "INSERT INTO tblBookInfo " +
												"VALUES(100000000000, 'SQLite 3', 30000, 1); ";
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
    	int nRet;
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        createDB();
        
        createTable();
        
      	// Insert Publisher Record
    	insertPublisherInfo();
    	
    	// Insert BookInfo Record
    	insertBookInfo();
    	
    	// Update BookInfo Record
    	nRet = updateBookInfoByISBN("100000000000");
    	Log.i(TAG, "Updated Record Count: " + nRet);
    	
    	// Delete BookInfo Record
    	nRet = deleteBookInfoByISBN("100000000000");
    	Log.i(TAG, "Deleted Record Count: " + nRet);
    	
    	// Select Single Table
    	selectTable();
    	// Cursor c = mDB.query("tblBookInfo", null, null, null, null, null, null);
    	// showTable(c);
    	
    	selectTableWithCondition();
    	
    	selectTableWithJoin();
    	
    	selectTableUsingRawQuery();
    	
    	closeDB();
    }
    
    private void createDB(){
    	// Create the DB
    	mDB = this.openOrCreateDatabase(DB_NAME, 
    			SQLiteDatabase.CREATE_IF_NECESSARY,
    			null);
    	
    	// Set DB configuration
    	mDB.setLocale(Locale.getDefault());
    	mDB.setLockingEnabled(true);
    	mDB.setVersion(1);
    	
    	// Get System Information
    	Log.i(TAG, "DB Path: " + mDB.getPath());
    	Log.i(TAG, "DB Path: " + mDB.getVersion());
    }
    
    private void closeDB(){
    	mDB.close();
    }
    
    private void createTable(){
    	// 외래키 설정 - Android Version 2.2 이상
    	mDB.execSQL("PRAGMA foreign_keys = 1");
    	
    	// Crean DB
    	// mDB.execSQL(DROP_TABLE_BOOKINFO);
    	// mDB.execSQL(DROP_TABLE_PUBLISHERINFO);
    	
    	// 테이블 생성
    	mDB.execSQL(CREATE_TABLE_PUBLISHERINFO);
    	mDB.execSQL(CREATE_TABLE_BOOKINFO);
    }
    
    
    
 
    private void selectTable()
    {
    	// SELECT * FROM tblBookInfo; 와 동일
    	Cursor c = mDB.query("tblBookInfo", /* 테이블 이름 */ 
    			null, /* 조회할 컬럼 이름 */
    			null, /* WHERE 절에 사용할 조건절 */
    			null, /* 조건절 인자 */
    			null, /* GROUPBY 절 */
    			null, /* HAVING 절 */
    			null, /* ORDERBY 절 */
    			null); /* LIMIT 절 */
    	showTable(c);
    	c.close();
    }
    
    private void selectTableWithCondition()
    {
    	// query(String table, String[] columns, String selection, String[] selectionArgs, String groupBy, String having, String orderBy, String limit)
    	// http://developer.android.com/reference/android/database/sqlite/SQLiteDatabase.html
    	// SELECT title, price FROM tblBookInfo
    	// WHERE publisher_id = 1
    	// ORDER BY title ASC;
    	Cursor c = mDB.query("tblBookInfo", 
    						new String[] {"title", "price"}, 
    						"publisher_id=?",
    						new String[] {"1"}, 
    						null, 
    						null,
    						"title ASC");
    	showTable(c);
    	c.close();
    }
    
    private void selectTableWithJoin()
    {
    	// http://developer.android.com/reference/android/database/sqlite/SQLiteQueryBuilder.html
    	SQLiteQueryBuilder qb = new SQLiteQueryBuilder();
 
    	// SELECT title, price, name
    	// FROM tblBook, tblPublisherInfo
    	// WHERE tblBookInfo.publisher_id = tblPublisherInfo.publisher_id
    	// ORDER BY title DESC;
    	
    	qb.setTables("tblBookInfo, tblPublisherInfo");
    	qb.appendWhere("tblBookInfo.publisher_id = tblPublisherInfo.publisher_id");
    	
    	// String astrColumns[] = {"tblBookInfo.title", "tblBookInfo.price", "tblPublisherInfo.name"};
    	// String astrColumns[] = {"title", "price", "name"};
    	// String strOrder = "title DESC";
    	
    	Cursor c = qb.query(mDB, 
    						new String[] {"title", "price", "name"},
    						null, 
    						null, 
    						null, 
    						null, 
    						"title DESC");
    						
    	showTable(c);
    	c.close();
    }
    
    private void selectTableUsingRawQuery()
    {
    	String strQuery = "SELECT title, price, name " +
        				  "FROM tblBookInfo, tblPublisherInfo " + 
        				  "WHERE tblBookInfo.publisher_id = tblPublisherInfo.publisher_id " +
        				  "AND name = ? "+
        				  "ORDER BY title DESC";
    	Cursor c = mDB.rawQuery(strQuery, new String[] {"Wikibooks"});
    	
    	showTable(c);
    	c.close();
    }
    
    private void showTable(Cursor c)
    {
    	Log.i(TAG, "==========================================================");
    	Log.i(TAG, "Result Set Count: " + c.getCount());
    	
    	// Print Header
    	String strHeader = "|| ";
    	int nHeaderCount = c.getColumnCount();
    	for (int i = 0; i < nHeaderCount; i++){
    		strHeader = strHeader.concat(c.getColumnName(i) +  " || ");
    	}
    	Log.i(TAG, "Header " + strHeader);
    	
    
		// Print records
		c.moveToFirst();
		while (c.isAfterLast() == false) {
			String strResults = "|| ";
			for (int i = 0; i < c.getColumnCount(); i++) {
				strResults = strResults.concat(c.getString(i) + " || ");
			}
			Log.i(TAG, "Row    " + strResults);
			c.moveToNext();
		}
		Log.i(TAG, "==========================================================");
    }
    
    private int deleteBookInfoByISBN(String strISBN)
    {
    	int nAffectedRow = mDB.delete("tblBookInfo", "isbn=?", new String[] {strISBN});
    	return nAffectedRow;
    }
    
    private int updateBookInfoByISBN(String strISBN)
    {
    	ContentValues values = new ContentValues();
    	values.put("price", 25000);
    	int nAffectedRow = mDB.update("tblBookInfo", values, "isbn=?", new String[] {strISBN});
    	
    	return nAffectedRow;
    }
    
    private void insertBookInfo()
    {
    	mDB.beginTransaction();
    	try{
        	mDB.execSQL(INSERT_SQLITE3);
        	mDB.execSQL("INSERT INTO tblBookInfo VALUES(300000000000, 'C++ Standard Library', 30000, NULL)");
        	mDB.execSQL("INSERT INTO tblBookInfo VALUES(400000000000, 'Steve Jobs'' Presentation', 13000, 2)");
        	mDB.execSQL("INSERT INTO tblBookInfo VALUES(500000000000, 'Computer Programming', 25000, 3)");
        	mDB.execSQL("INSERT INTO tblBookInfo VALUES(600000000000, 'iPhone programming', 26000, 1)");
        	mDB.execSQL("INSERT INTO tblBookInfo VALUES(700000000000, 'Android programming', 36000, 1)");
        	mDB.execSQL("INSERT INTO tblBookInfo VALUES(800000000000, 'Hacking Guide', 14000, 3)");
        	mDB.execSQL("INSERT INTO tblBookInfo VALUES(900000000000, 'How to play the iPhone', 7000, 2)");
        	mDB.execSQL("INSERT INTO tblBookInfo VALUES(110000000000, 'Computer Programming', 7000, 4)");
        	
        	mDB.setTransactionSuccessful();
    	}catch(Exception e){
    		
    	} finally {
    		mDB.endTransaction();
    	}
    	
    }
    
    private void insertPublisherInfo()
    {
    	mDB.beginTransaction();
    	try{
        	ContentValues values = new ContentValues();
        	values.put("name", "Wikibooks");
        	mDB.insert("tblPublisherInfo", null, values);
        	
        	values = new ContentValues();
        	values.put("name", "Apple Press");
        	mDB.insert("tblPublisherInfo", null, values);
        	
        	values = new ContentValues();
        	values.put("name", "Apress");
        	mDB.insert("tblPublisherInfo", null, values);
        	
        	values = new ContentValues();
        	values.put("name", "IT Press");
        	mDB.insert("tblPublisherInfo", null, values);
        	
        	mDB.setTransactionSuccessful();
    	}catch(Exception e){
    		
    	} finally {
    		mDB.endTransaction();
    	}
    	
    }
}