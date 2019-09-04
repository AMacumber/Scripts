/* Save on System Resources. Clear Work Library or Temp files */

* posted by: ;
* https://communities.sas.com/t5/SAS-Enterprise-Guide/Clearing-the-work-library-on-a-Workspace/td-p/521503;

/* create a new lib as a subfolder of WORK */
options dlcreatedir;
libname mywork "%sysfunc(getoption(WORK))/mywork";

/* optional: one-level names will default to MYWORK lib */
options user=mywork;

/* Use and enjoy */
data one two three;
set sashelp.class;run;

/* cleanup MYWORK before the next task */
* suppress printing of lists and details;
proc datasets nolist nodetails lib=mywork kill;
