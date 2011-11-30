package #{package};

import java.io.Serializable;

import android.app.Activity;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.Window;
import android.view.WindowManager;

public class ManagedActivity extends Activity {
	
	public final static String DefaultDataTag = "DEFAULTDATA";
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
	}

	@Override
	public void onPause() {
		super.onPause();
		
		ActivityFlowManager.getInstance().notifyActivityHidden(this);
	}
	
	@Override
	public void onResume() {
		super.onResume();
		
		ActivityFlowManager.getInstance().notifyActivityShown(this);
	}
	
	public boolean handleCommand(ActivityCommandType commandType, Serializable extraData) {
		return ActivityFlowManager.getInstance().handleCommand(commandType, extraData);
	}
}
