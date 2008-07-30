/****************************************************************************
** Ui.h extension file, included from the uic-generated form implementation.
**
** If you want to add, delete, or rename functions or slots, use
** Qt Designer to update this file, preserving your code.
**
** You should not define a constructor or destructor in this file.
** Instead, write your code in functions called init() and destroy().
** These will automatically be called by the form's constructor and
** destructor.
*****************************************************************************/
#include "Draw.h"
#include "Canvas.h"
#include "GraphInfos.h"
#include "Helper.h"
#include "formviewdata.h"
#include "CanvasCollection.h"
#include "formOpenFile.h"
#include "formAbout.h"

#include <qstatusbar.h>
#include <qfiledialog.h>
#include <qmessagebox.h>
#include <qinputdialog.h>
#include <qobjectlist.h>
#include "TQtWidget.h"

#include <string>
#include <vector>
#include <sstream>
#include <stdio.h>

#ifdef DEBUG
#include <iostream>
#endif

#define NOT_IMPLEMENTED QMessageBox::information(this, \
					    "Message","Sorry, not implemented yet." );

using namespace std;


//----------------------------------------------------------------------

Draw * draw = new Draw(); //the Draw object for drawing stuff

//pointers for creating new tab with TQtWidget in it
QWidget * newTab; // pointer to newly created tab
TQtWidget * newTqtw; // pointer to newly created TQtWidget
QVBoxLayout * newLayout; // pointer for laying out TQtWidget properly

// filters for saving to files
static string fileTypeFilterSingle = "Postscript (*.ps);;"
                                     "Root File (*.root);;"
                                     "Encapsulated Postscript (*.eps);;"
                                     "PDF (*.pdf);;"
                                     "JPEG (*.jpg);;"
                                     "GIF (*.gif);;"
                                     "C++ Macro (*.cxx)";
static string fileTypeFilterMultiple = "Postscript (*.ps);;"
                                       "Encapsulated Postscript (*.eps)";


// keeping track of the corresponding tabnames in the listview
// and the widgetstack
vector<int> tabIds;
vector<QListViewItem*> tabNames;
CanvasCollection canvases;

bool multiGraphCont = false;
// statusbar
QLabel* lblStatus;
QLabel* lblEventCutStatus;

//---------------------------------------------------------------------


void MainForm::init()
{
	//don't sort the listview - it messes up the order of inserting tabs
	lvGraphs->setSorting(-1);

	//populate the graph type drop-down list
	for (int i = 0; i < Canvas::numberOfGraphTypes(); ++i)
		cmbGraphType->insertItem(Canvas::getDescription(
									 (Canvas::graphTypes) i));
	
	// set up statusbar; important: don't attempt to write to status bar
	// before this!!!
	lblStatus = new QLabel("Ready",this);
	lblEventCutStatus = new QLabel("Current number of events: 00000",this);
	lblStatus->setMinimumSize(lblStatus->sizeHint());
	statusBar()->addWidget(lblStatus,1);
	statusBar()->addWidget(lblEventCutStatus);
		
	addNewTab();	
	fileOpen();
	
}

void MainForm::fileOpen()
{
	formOpenFile f(this);
	f.initialize(draw->rootTree);
	
	if (f.exec())
		draw->rootTree = f.getReadRootTree();
	else if (!(draw->rootTree)) // for the first time when program opens
	{
		QMessageBox::information(this,"Open files",
								 "You must select some root files to"
								 "start with! Use File -> "
								 "Open to open root files.");
 		return;
	}

	txtEventCut->setText("");
	applyRootCut();
	fillBranchNames();

	this->setCaption("Browser - " +
					 joinStrings(draw->rootTree->getListOfFiles(),"; "));
	//changeStatus("Opened files: " + joinStrings(filenames, ", "));
}

void MainForm::fileSave()
{
	QString file = QFileDialog::getSaveFileName(
		           validateFilename(tabNames[getTabIndex()]->text(0)),
					fileTypeFilterSingle,
                    this,
                    tr("save file dialog"),
                    tr("Choose a filename to save under"));


	if (file) draw->saveAs(NULL,file.ascii());
}


void MainForm::fileSaveAllSingle()
{
	int tabcount = (int) tabIds.size();
	TQtWidget * tqtw;

	if (tabcount < 1) return;

	QString file = QFileDialog::getSaveFileName("",
					fileTypeFilterMultiple,
                    this,
                    tr("save file dialog"),
                    tr("Choose a filename to save under"));

	if (!file) return;

	//open for saving multiple canvas in one file
	draw->saveAs(NULL,file.ascii(),Draw::OPEN_ONLY); 
	
	for (int i = 0; i<tabcount ; i++)
	{
		tqtw = (TQtWidget*) wgStack->widget(tabIds[i])
			    ->child("tqtw","TQtWidget", FALSE);
		if (tqtw)
		{
			draw->saveAs(tqtw->GetCanvas(),file.ascii());
		}
	}

	draw->saveAs(NULL,file.ascii(),Draw::CLOSE_ONLY);
}

void MainForm::fileSaveAllMultiple()
{
	NOT_IMPLEMENTED
}

void MainForm::fileExit()
{
	close();
}
void MainForm::filePrint()
{
	NOT_IMPLEMENTED
}

void MainForm::helpAbout()
{
	formAbout f(this);
	f.exec();
}


void MainForm::enableDrawButton()
{
	// the draw button should be disabled if not everything neccesary for
	// for drawing the specific graph is present
	
	if (wgsAction->visibleWidget() == tabGraph2D)
	{
		btnDraw->setEnabled(!txt2DXAxis->text().isEmpty() &&
			                !txt2DYAxis->text().isEmpty());
		if (ckb2DErrors->isChecked())
			btnDraw->setEnabled(!txt2DXAxisError->text().isEmpty() &&
								!txt2DYAxisError->text().isEmpty());
	}
	else if (wgsAction->visibleWidget() == tabPosition)
	{
		btnDraw->setEnabled(true);
	}
	else if (wgsAction->visibleWidget() == tabShowerAngles)
	{
		btnDraw->setEnabled(!txtPolarRAxis->text().isEmpty() &&
			                !txtPolarThetaAxis->text().isEmpty());
	}
	else if (wgsAction->visibleWidget() == tabGraphPolar)
	{
		btnDraw->setEnabled(!txtPolarRAxis_2->text().isEmpty() &&
			                !txtPolarThetaAxis_2->text().isEmpty());
		if (ckb2DErrors->isChecked())
			btnDraw->setEnabled(!txtPolarRAxisError->text().isEmpty() &&
								!txtPolarThetaAxisError->text().isEmpty());
	}

// ## uncomment below to add another graph type ##
//	else if (wgsAction->visibleWidget() = _the "tab page" widget you created_)
//	{
//		btnDraw->setEnabled(_true if all the neccesary fields are completed;
//							false otherwise);
//	}
			 
}

void MainForm::Draw()
{
	if (ckbNewTab->isChecked())
		addNewTab();
	
	if (wgsAction->visibleWidget() == tabPosition)
	{
		switch (cmbPositionType->currentItem())
		{
			case 0:
				draw->drawGrandeCoordinates();
				renameTab("Grande Coordinates");
				break;
			case 1:
				draw->drawAntennaPosition();
				renameTab("Antenna Position");
				break;
		}
	}
	else if (wgsAction->visibleWidget() == tabGraph2D)
	{
		cout << "x" <<txt2DXAxis->text().ascii() << endl;
		cout << "y" << txt2DYAxis->text().ascii() << endl; 

		draw->draw2DGraph(txt2DXAxis->text().ascii(),
						  txt2DYAxis->text().ascii(),
			(ckb2DErrors->isChecked())? txt2DXAxisError->text().ascii() : NULL,
			(ckb2DErrors->isChecked())? txt2DYAxisError->text().ascii() : NULL
			 );

		renameTab(txt2DXAxis->text() + " - " + txt2DYAxis->text());
	}
	else if (wgsAction->visibleWidget() == tabShowerAngles)
	{
		cout << "r=" <<txtPolarRAxis->text().ascii() << endl;
		draw->drawShowerAngles(txtPolarRAxis->text().ascii(),
						       txtPolarThetaAxis->text().ascii(),
							   txtColorCode->text().ascii()	);
		
		renameTab(txtEventCut->text());
	}
 // ## uncomment below to add another graph type ##
//	else if (wgsAction->visibleWidget() = _the "tab page" widget you created_)
//	{
//	    use the object draw to draw stuff here; root has already been cd to the
//	    current canvas
//      also do renameTab(_name_) to change the name of the tab to a more
//      description name   	
//	}
}

void MainForm::applyRootCut()
{
	if (!draw->rootTree) return;
	
	draw->rootTree->setEventCut(txtEventCut->text().ascii());
	btnApplyCut->setEnabled(false);

	QString status  = QString("Current number of events: %1")
		.arg(draw->rootTree->getNumberEntries());

	cout << status << endl;

	lblEventCutStatus->setText(status);
}


void MainForm::txtEventCut_changed()
{
	btnApplyCut->setEnabled(true);
}

void MainForm::addNewTab(Canvas* c)
{
	if (!c) return;
	
	int id = -1;
	QListViewItem * item;
	
	newTab = new QWidget(wgStack,"tab_"); //todo add number!
	newTqtw = new TQtWidget(newTab,"tqtw");
	newLayout = new QVBoxLayout(newTab,0,6,"tabLayout");
	newLayout->addWidget(newTqtw);
	
	id = wgStack->addWidget(newTab);

	if (id != -1)
	{
		tabIds.push_back(id);

		//create an item after the last one in the listview
		item = new QListViewItem(lvGraphs,
			  (tabNames.size() == 0)? 0 : tabNames[(int)tabNames.size() - 1],
								 c->getName());
		tabNames.push_back(item);
		
		//focus on the newly created tab
		lvGraphs->setSelected(item,true);

		// make sure that the correct TQtWidget is the current Canvas
		setTabAsCanvas(newTab);
	}

}

void MainForm::addNewTab()
{
	Canvas *c = new Canvas();
	c->setName("Untitled Canvas");
	int index = getTabIndex();

	if (index > 0)
		c->setGraphType(canvases.at(index)->getGraphType());
	else
		c->setGraphType(Canvas::GRAPH_2D); // default to 2D graph

	canvases.push_back(c);
	
	addNewTab(c);	
}

void MainForm::enableTabActionButtons()
{
	bool y = (getTabIndex() != -1);
	
	btnRemoveTab->setEnabled(y);
	btnRenameTab->setEnabled(y);
}


void MainForm::setTabAsCanvas( QWidget * qw )
{
	// find the TQtWidget belong to the tab page
	TQtWidget * tqtw = (TQtWidget*) qw->child("tqtw","TQtWidget", FALSE);
	// if found, set it as current canvas for drawing
	if (tqtw) draw->setCanvas(tqtw->GetCanvas());
}


// get the index in the arrays tabIds and tabNames for the currently selected
int MainForm::getTabIndex()
{
	return getTabIndex(wgStack->id(wgStack->visibleWidget()));
}


int MainForm::getTabIndex( int widgetID )
{
	int id = (widgetID == 0)? wgStack->id(wgStack->visibleWidget()) : widgetID;

	if (id == 0) return -1;

	for (int i = 0; i < (int)tabIds.size(); i++)
		if (tabIds[i] == id) return i;

	return -1;
}

int MainForm::getTabIndex( QListViewItem * item )
{
	if (!item) return -1;
	
	// find the index for item corresponding to this QListViewItem
	for (int i = 0; i < (int)tabIds.size(); i++)
		if (tabNames[i] == item) return i;

    return -1;
}

void MainForm::selectTab( QListViewItem * sel)
{
	saveToCanvas();
	
	multiGraphCont = false; // make sure that a new graph with axis is started
	
	int index = (sel)? getTabIndex(sel) : getTabIndex();
	int id;
//	int subpad;

	if (index < 0) //not a canvas; select subpad if applicable
	{
		if (!sel || !sel->parent()) return;

		index = getTabIndex(sel->parent());

		if (index < 0) return;

		// todo cd to the subpad

		return;
	}

	id = tabIds[index];
	
	if (id == 0)
		wgStack->raiseWidget(wgStack->id(wgEmtpyPage));
	else
		wgStack->raiseWidget(id);

	loadCanvas(canvases.at(index));
}

// load the inforamtion from the object Canvas to the user interface
void MainForm::loadCanvas(Canvas* c)
{
	if (!c) return;

	txtEventCut->setText(c->getEventCut());
	applyRootCut();

	renameTab(c->getName());
	wgsAction->raiseWidget(findGraphWidget(c->getGraphType()));
	cmbGraphType->setCurrentItem(c->getGraphType());
	
	switch (c->getGraphType())
	{
		case Canvas::GRAPH_2D:
		{
			infoGraph2D* info = (infoGraph2D*) c->getGraphInfo();

			ckb2DErrors->setChecked(info->useErrors);
			txt2DXAxis->setText(info->xAxis);
			txt2DYAxis->setText(info->yAxis);
			txt2DXAxisError->setText(info->xAxis_err);
			txt2DYAxisError->setText(info->yAxis_err);
			break;
		}
		case Canvas::SHOWER_ANGLE:
		{
			infoShowerAngle* info2 = (infoShowerAngle*) c->getGraphInfo();

			txtPolarThetaAxis->setText(info2->thetaAxis);
			txtPolarRAxis->setText(info2->rAxis);
			txtColorCode->setText(info2->colorCodeBy);
			break;
		}
		case Canvas::GRAPH_POLAR:
		{
			//todo
			break;
		}
		case Canvas::ANTENNA_POSITION:
		{
			// nothing to do...
			break;
		}
		// ## add the case for new graph type here
		// case Canvas::_your new enum graph type enum name_:
		// {
		//     fill in the values like above
		// }
		default:
		{
			cout << "hmm, this should not happen..." << endl;
		}
	}
			
}

// save the current text fields, such as event cut, etc.  to the object Canvas
void MainForm::saveToCanvas()
{
	int index = getTabIndex();
	if (index < 0) return;

	Canvas* c = canvases.at(index);
	if (!c) return;

	c->setEventCut(txtEventCut->text().ascii());
	c->setName(tabNames[index]->text(0));

	if (wgsAction->visibleWidget() == tabPosition)
	{
		c->setGraphType(Canvas::ANTENNA_POSITION);
	}
	else if (wgsAction->visibleWidget() == tabGraph2D)
	{
		c->setGraphType(Canvas::GRAPH_2D);

		infoGraph2D* info = (infoGraph2D*) c->getGraphInfo();
		info->useErrors = ckb2DErrors->isChecked();
		info->xAxis = string(txt2DXAxis->text().ascii());
		info->yAxis = txt2DYAxis->text().ascii();
		info->xAxis_err = txt2DXAxisError->text().ascii();
		info->yAxis_err = txt2DYAxisError->text().ascii();
	}
	else if (wgsAction->visibleWidget() == tabShowerAngles)
	{
		c->setGraphType(Canvas::SHOWER_ANGLE);
		
		infoShowerAngle* info2 = (infoShowerAngle*) c->getGraphInfo();
		info2->rAxis = txtPolarRAxis->text().ascii();
		info2->thetaAxis = txtPolarThetaAxis->text().ascii();
		info2->colorCodeBy = txtColorCode->text().ascii();
	}
// ## uncomment below to add another graph type ##
//	else if (wgsAction->visibleWidget() = _the "tab page" widget you created_)
//      c->setGraphType(Canvas::_your identification set in Canvas.h_);

	canvases.saveToFile("f");
}

void MainForm::removeTab()
{
	int index = getTabIndex();
	if (index > -1)
		removeTab(index);
}

void MainForm::removeTab( int index )
{
	if (index < 0 || index > (int) tabIds.size()) return;

	// the new index to be selected
	int s_index = ((index == (int)tabIds.size() - 1)?
				   (index - 1) : (index + 1));

	cout << "select index " << s_index << endl;
	
 	// select the tab above
	if (s_index > 0)
		selectTab(tabNames[s_index]); 

	delete tabNames[index];

	tabIds.erase(tabIds.begin() +  index);
	tabNames.erase(tabNames.begin() + index);
}

// rename the current tab, asking the user for the new name
void MainForm::renameTab()
{
	int index = getTabIndex();
	if (index > -1)
		renameTab(index);
}

// rename the tab of index "index", asking user for the new name
void MainForm::renameTab(int index)
{
	if (index < 0 || index > (int) tabIds.size()) return;

	bool ok;
	
	QString name = QInputDialog::getText(tr("Rename Canvas"),
										 tr("Enter a new name:"),
										 QLineEdit::Normal,
										 tabNames[index]->text(0),
										 &ok,
										 this);
	if (ok && !name.isEmpty())
		renameTab(index,name);
}

// rename the current tab to "name"
void MainForm::renameTab(QString name)
{
	int index = getTabIndex();
	if (index > -1)
		renameTab(index,name);
}

// rename the tab of index "index" to "name"
void MainForm::renameTab(int index, QString name)
{
	if (index < 0 || index > (int) tabIds.size()) return;

//	QListViewItem * item = tabNames[index];
		
	if (tabNames[index])
		tabNames[index]->setText(0,name);
}

void MainForm::divideCanvas()
{
	bool ok;
	
	QString s = QInputDialog::getText(tr("Divide Canvas"),
									  tr("How to divide? e.g. 3x2"),
									  QLineEdit::Normal,
									  "3x2",
									  &ok,
									  this);
	if (ok && !s.isEmpty())
	{
		int n_columns, n_rows;
		sscanf(s.ascii(),"%ix%i",&n_columns,&n_rows);
		divideCanvas(n_columns,n_rows);
	}	
}

void MainForm::divideCanvas(int n_columns, int n_rows)
{
	draw->divideCanvas(n_columns,n_rows);
	addNewSubPad(n_rows * n_columns);
}

void MainForm::addNewSubPad( int n_subpad )
{
	QListViewItem * parent_item = tabNames[getTabIndex()];

	if (!parent_item) return;
	
	QListViewItem * child_item, *after_item;
	ostringstream ss;

	// find the last child under the parent_item
	after_item = parent_item->firstChild();
	if (after_item)
	{
		while (after_item->nextSibling() != 0)
			after_item = after_item->nextSibling();
	}
	
	// rename the new subpads to Pad 1, Pad 2, etc.
	for (int i = 1; i <= n_subpad; i++)
	{
		ss.str("");
		ss << "Pad " << i;
		
		if (after_item)
			child_item = new QListViewItem(parent_item,after_item,ss.str());
		else
			child_item = new QListViewItem(parent_item,ss.str());

		after_item = child_item;
	}

	parent_item->setOpen(true);
}

void MainForm::clearGraph()
{
	draw->clearCanvas();
}

void MainForm::setMultigraphStatus( bool state )
{
	draw->setMultiGraph(state);
}

void MainForm::saveEventCut()
{
	cmbEventCuts->insertItem(txtEventCut->text());
}

void MainForm::changeStatus(QString status)
{
    lblStatus->setText(status);
}

QWidget* MainForm::findGraphWidget(Canvas::graphTypes type)
{
	switch (type)
	{
		case Canvas::GRAPH_2D:           return tabGraph2D;
		case Canvas::SHOWER_ANGLE:       return tabShowerAngles;
		case Canvas::ANTENNA_POSITION:   return tabPosition;
		default:                         return tabUnknown;
	   // ## add case for new graph type; see example above
	}
		
}

void MainForm::selectGraphType( int index )
{
	Canvas::graphTypes type = (Canvas::graphTypes) index;
	cout << type << endl;
	
	QWidget* w = findGraphWidget(type);

	if (w)
		wgsAction->raiseWidget(w);
	//canvases.at(getTabIndex())->setGraphType(type);
	
}

void MainForm::viewData()
{
    static formViewData* f;

	if (!f)
		f = new formViewData(this);
	
    f->initialize(draw->rootTree);
    f->show();
	f->raise();
	f->setActiveWindow();
}

void MainForm::fillBranchNames()
{
	if (!draw->rootTree) return;

	cmbBranchNames->clear();
	
	vector<string> names = draw->rootTree->getBranchNames();
	for (int i = 0; i < (int) names.size(); i++)
		cmbBranchNames->insertItem(names[i]);
}

void MainForm::insertBranchName( const QString& name )
{
	// find the QLineEdit or QTextEdit that has focus and append the branch
	// name to it; the find method relies on the fact that all the textboxes
	// are named with prefix txt
	QObjectList *l = topLevelWidget()->queryList(NULL,"txt*");
    QObjectListIt it( *l );
	QWidget* w;
		
    while ((w = (QWidget*) it.current()) != 0 )
	{
		++it;
		if (w->hasFocus())
		{
			if (dynamic_cast<QLineEdit*>(w) != 0)
			{
				((QLineEdit*)w)->setText(((QLineEdit*)w)->text() + name);
				break;
			}

			if ((QTextEdit*)w != 0)
			{
				((QTextEdit*)w)->setText(((QTextEdit*)w)->text() + name);
				break;
			}
		}
    }

    delete l; 
}
