package #{package};

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import android.content.Intent;
import android.util.Log;

public class ActivityFlowManager {
	private static ActivityFlowManager sInstance = null;
	
	private static Object sLockObj = new Object();
	
	private static final String LOGTAG = ActivityFlowManager.class.getName();
	
	private ManagedActivity mTopActivity = null;
	
	private Map<Class<?>, Map<ActivityCommandType, Class<?>>> mTransitionTables = new HashMap<Class<?>, Map<ActivityCommandType, Class<?>>>();

	private Map<ActivityCommandType, Class<?>> mCurrentTable = null;
	
	private ActivityFlowManager() {
		inititalizeTransitions();
	}
	
	private void inititalizeTransitions() {
		Map<ActivityCommandType, Class<?>> table = null;
		
#{transition_table}
	}
	
	public static ActivityFlowManager getInstance() {
		if (sInstance == null) {
			synchronized (sLockObj) {
				if (sInstance == null) {
					sInstance = new ActivityFlowManager();
				}
			}
		}
		
		return sInstance;
	}
	
	public void notifyActivityShown(ManagedActivity activity) {
		if (mTopActivity != null) {
			throw new RuntimeException("Activity shown while another activity not hidden!");
		}
		
		mTopActivity = activity;
		mCurrentTable = mTransitionTables.get(activity.getClass());
	}
	
	public void notifyActivityHidden(ManagedActivity activity) {
		if (activity != mTopActivity) {
			throw new RuntimeException("Activity being hidden does not match top activity!");
		}
		
		mTopActivity = null;
		mCurrentTable = null;
	}
	
	public boolean handleCommand(ActivityCommandType commandType, Serializable extraData) {
		Class<?> nextActivity = mCurrentTable.get(commandType);
		
		if (nextActivity != null) {
			Intent intent = new Intent(mTopActivity, nextActivity);
			
			if (extraData != null) {
				intent.putExtra(ManagedActivity.DefaultDataTag, extraData);
			}

			mTopActivity.startActivity(intent);
			return true;
		}
		
		return false;
	}
}
