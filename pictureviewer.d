// To compile:
// 	dfl pictureviewer -gui
// or
// 	dmd pictureviewer.d dfl.lib -L/exet:nt/su:windows:4.0

private import dfl.all;

class PictureForm: Form
{
	PictureBox pic;
	
	this()
	{
		startPosition = FormStartPosition.WINDOWS_DEFAULT_BOUNDS;
		text = "DFL Picture Viewer";
		backColor = SystemColors.appWorkspace;
		
		with(pic = new PictureBox)
		{
			sizeMode = PictureBoxSizeMode.AUTO_SIZE;
			parent = this;
		}
		
		menu = new MainMenu;
		MenuItem mpop, mi, mabout, mhelp;
		
		with(mpop = new MenuItem)
		{
			text = "&File";
			index = 0;
			menu.menuItems.add(mpop);
		}
		with(mhelp = new MenuItem) {
			text = "&Help";
			index = 1;
			menu.menuItems.add(mhelp);
		}
		with(mabout = new MenuItem) {
			text = "&About... \tF1";
			index = 0;
			mhelp.menuItems.add(mabout);
			click ~= &about_click;
		}
		addShortcut(Keys.F1, &shortcut_help);
		with(mi = new MenuItem)
		{
			text = "&Open...\tCtrl+O";
			index = 0;
			mpop.menuItems.add(mi);
			click ~= &file_open_click;
		}
		addShortcut(Keys.CONTROL | Keys.O, &shortcut_open);
		
		with(mi = new MenuItem)
		{
			text = "-";
			index = 1;
			mpop.menuItems.add(mi);
		}
		
		with(mi = new MenuItem)
		{
			text = "E&xit";
			index = 2;
			mpop.menuItems.add(mi);
			click ~= &file_exit_click;
		}
	}
	
	
	final void doOpen()
	{
		OpenFileDialog ofd;
		ofd = new typeof(ofd);
		ofd.title = "Open Image";
		ofd.filter = "Bitmap Files (*.bmp)|*.bmp|All Files|*.*";
		
		if(DialogResult.OK == ofd.showDialog())
		{
			pic.image = new Bitmap(ofd.fileName);
		}
	}
	
	
	private void file_open_click(Object sender, EventArgs ea)
	{
		doOpen();
	}
	private void shortcut_open(Object sender, FormShortcutEventArgs ea)
	{
		doOpen();
	}
	private void file_exit_click(Object sender, EventArgs ea)
	{
		Application.exitThread();
	}
	private void shortcut_help(Object sender, FormShortcutEventArgs ea) {
		msgBox("hi");
	}
	private void about_click(Object sender, EventArgs ea) {
		msgBox("hi click");
	}
}


int main()
{
	int result = 0;
	
	try
	{
		// Application initialization code here.
		
		Application.run(new PictureForm);
	}
	catch(Object o)
	{
		msgBox(o.toString(), "Fatal Error", MsgBoxButtons.OK, MsgBoxIcon.ERROR);
		
		result = 1;
	}
	
	return result;
}
