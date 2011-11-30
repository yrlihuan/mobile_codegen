package #{package};

import android.view.View;
import android.view.View.OnClickListener;

public abstract class SimpleOnClickHandler implements OnClickListener, Runnable {
	@Override
	public abstract void run();

	@Override
	public void onClick(View v) {
		run();
	}
}
