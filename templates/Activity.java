package #{package};

import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.TextView;

public class #{activity} extends ManagedActivity {
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.#{layout});
		setDefaultEventHandlers();
	}
	
	private void setDefaultEventHandlers() {
#{register_events}
	}
	
#{handler_definitions}
}
