package net.fast_learner;

import android.app.Activity;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class SQLiteCommander extends Activity {
	private SQLiteDatabase mDB;
	private static final String DB_NAME = "SQLiteCommander.db";
	
	static Button btnRun = null;
	static EditText etInputQuery = null;
	static EditText etResult = null;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
		btnRun = (Button)this.findViewById(R.id.btnRun);
        etInputQuery = (EditText)this.findViewById(R.id.etInputQuery);
        etResult = (EditText)this.findViewById(R.id.etResult);
    }
    
    @Override
	protected void onPause() {
    	// ���ø�Ű�̼��� Pause ���°� �� ��, �����ͺ��̽� ������ ����
    	mDB.close();
		super.onPause();
	}
    
    @Override
	protected void onResume() {
    	// ���ø����̼��� Resume ���°� �� ��, �����ͺ��̽��� ����
    	mDB = this.openOrCreateDatabase(DB_NAME, 
    			SQLiteDatabase.CREATE_IF_NECESSARY,
    			null);    	
		super.onResume();
	}

    private void appendResult(String strMsg)
    {
    	etResult.append(strMsg + "\n");
    }
        
    private void execute(String strSQL)
    {
    	// DML, DDL ������ ����
    	try{
    		mDB.execSQL(strSQL);
    	}catch(SQLException e)
    	{
    		appendResult("Fail to execute " + "\n" + e.getMessage());
    		return;
    	}
    	appendResult("Success to execute.\n");
    }
    
    private void select(String strSQL)
    {
    	try{
    		Cursor c = mDB.rawQuery(strSQL, null);
    		showResultSet(c);
    		c.close();
    	}catch(SQLException e)
    	{
    		appendResult("Fail to execute " + "\n" + e.getMessage());
    		return;
    	}
    }
    
    private void showResultSet(Cursor c)
    {
    	StringBuilder sb = new StringBuilder();
    	sb.append("========================================\n");
    	sb.append("Result Set Count: " + c.getCount() + "\n");
    	
    	// �÷� ��� ���
    	sb.append("|");
    	int nHeaderCount = c.getColumnCount();
    	for (int i = 0; i < nHeaderCount; i++){
    		sb.append(c.getColumnName(i) +  "|");
    	}
    	
    	// ���ڵ� ���
    	c.moveToFirst();
		while (c.isAfterLast() == false) {
			sb.append("\n|");
			for (int i = 0; i < c.getColumnCount(); i++) {
				sb.append(c.getString(i) + "|");
			}
			c.moveToNext();
		}
		sb.append("\n========================================\n");
		appendResult(sb.toString());	
    }

    public void btnRunClick(View btnRun)
    {
    	String strQuery = etInputQuery.getText().toString().trim();
    	// �Էµ� ���ڿ��� ���� ���, ����
    	if(strQuery.equals(""))	return;
    	appendResult("SQL> " + strQuery);
    	if(strQuery.startsWith("SELECT") || strQuery.startsWith("select"))
    		select(strQuery);	// SELECT ������ ���
    	else
    		execute(strQuery);	// �׿� DML, DDL ������ ���
    	
    	// �Է� ���� �ʱ�ȭ
    	etInputQuery.setText("");    	
    }    
}