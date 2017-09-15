## DEBUG API
## 1.1 check()
> * #define check( X )
> > - [x] Check that an expression is true (non-zero)
> > - [x] ************Parameters:************

    [in]  X       expression to be checked

## 1.2 check_string()
> * #define check_string( X, STR )
> > - [x] Check that an expression is true (non-zero) with an explanation
> > - [x] ************Parameters:************

    [in]  X     string to be checked
    [in]  STR   if expression evaluate to false,custom explanation string to print 

## 1.3 require()
> * #define require( X, LABEL )
> > - [x] Requires that an expression evaluate to true
> > - [x] ************Parameters:************

    [in]  X        expression to be evalulated
    [in]  LABEL    if expression evaluate to false,jumps to the label

## 1.4 require_string()
> * #define require_string( X, LABEL, STR )
> > - [x] Requires that an expression evaluate to true with an explanation
> > - [x] ************Parameters:************

   [in]  X        expression to be evalulated
   [in]  LABEL    if expression evaluate to false,jumps to a label.
   [in]  STR      if expression evaluate to false,custom explanation string to print 

## 1.5 require_quiet()
> * #define require_quiet( X, LABEL )
> > - [x] Requires that an expression evaluate to true
> > - [x] ************Parameters:************

   [in]  X        expression to be evalulated
   [in]  LABEL    if expression evaluate to false,this jumps to the label

## 1.6 require_noerr()
> * #define require_noerr( ERR, LABEL )
> > - [x] Require that an error code is noErr (0)
> > - [x] ************Parameters:************

   [in]  ERR      error to be evalulated
   [in]  LABEL    if expression evaluate to false,this jumps to the label

## 1.7 require_noerr_string()
> * #define require_noerr_string( ERR, LABEL, STR )
> > - [x] Require that an error code is noErr
> > - [x] ************Parameters:************

    [in]  ERR       error to be evaluated
    [in]  LABEL     If the error code is non-0, jumps to the LABEL.
    [in]  STR       If the error code is non-0, custom explanation string to print 

## 1.8 require_noerr_action_string()
> * #define require_noerr_action_string( ERR, LABEL, ACTION, STR )
> > - [x] Require that an error code is noErr (0)
> > - [x] ************Parameters:************

    [in]  ERR       error to be evaluated
    [in]  LABEL     If the error code is non-0, jumps to the LABEL.
    [in]  ACTION    custom code to executes
    [in]  STR       custom explanation string to print 

## 1.9 require_noerr_quiet()
> * #define require_noerr_quiet( ERR, LABEL ) 
> > - [x] Require that an error code is noErr (0)
> > - [x] ************Parameters:************

    [in]  ERR       error to be evaluated
    [in]  LABEL     If the error code is non-0, jumps to the LABEL

## 1.10 require_noerr_action()
> * #define require_noerr_action( ERR, LABEL, ACTION )  
> > - [x] Require that an error code is noErr (0) with an action to execute otherwise
> > - [x] ************Parameters:************

    [in]  ERR       error to be evaluated
    [in]  LABEL     If the error code is non-0, jumps to the LABEL
    [in]  ACTION    custom code to executes

## 1.11 require_noerr_action_quiet()
> * #define require_noerr_action_quiet( ERR, LABEL, ACTION )  
> > - [x] Require that an error code is noErr (0) with an action to execute otherwise
> > - [x] ************Parameters:************

    [in]  ERR       error to be evaluated
    [in]  LABEL     If the error code is non-0, jumps to the LABEL
    [in]  ACTION    custom code to executes

## 1.12 require_action()
> * #define require_action( X, LABEL, ACTION )  
> > - [x] Requires that an expression evaluate to true with an action to execute otherwise
> > - [x] ************Parameters:************

    [in]  X         expression to be evaluated
    [in]  LABEL     If the error code is non-0, jumps to the LABEL
    [in]  ACTION    custom code to executes

## 1.13 require_action_string()
> * #define require_action_string( X, LABEL, ACTION, STR )   
> > - [x] Requires that an expression evaluate to true with an explanation and action to execute otherwise
> > - [x] ************Parameters:************

    [in]  X         expression to be evaluated
    [in]  LABEL     If the error code is non-0, jumps to the LABEL
    [in]  ACTION    custom code to executes
    [in]  STR       custom string to print

## 1.14 require_action_quiet()
> * #define require_action_quiet( X, LABEL, ACTION )  
> > - [x] Requires that an expression evaluate to true with an action to execute otherwise
> > - [x] ************Parameters:************

    [in]  X         expression to be evaluated
    [in]  LABEL     If the error code is non-0, jumps to the LABEL
    [in]  ACTION    custom code to executes