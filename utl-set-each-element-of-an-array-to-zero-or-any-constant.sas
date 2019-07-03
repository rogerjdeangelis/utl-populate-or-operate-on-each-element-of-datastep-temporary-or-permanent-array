Set each element of an array to zero or any constant                                                                  
                                                                                                                      
  Problem                                                                                                             
      Given an array with all elements=1.                                                                             
      Zero out the arra. Set all elements to zero                                                                     
                                                                                                                      
  Six Solutions                                                                                                       
                                                                                                                      
     a. Call stdize                                                                                                   
        by FreelanceReinhard                                                                                          
        https://communities.sas.com/t5/user/viewprofilepage/user-id/32733                                             
                                                                                                                      
     b. Classic Do loop                                                                                               
                                                                                                                      
     c. FCMP call fillmatrix                                                                                          
        Paul Dorfman                                                                                                  
        sashole@bellsouth.net                                                                                         
                                                                                                                      
     d. Array fill macro to each element (allows any constant)                                                        
                                                                                                                      
     e. Macro do_over (simple and more clear than a macro?)                                                           
                                                                                                                      
     f. Pokelong                                                                                                      
        Paul Dorfman                                                                                                  
        sashole@bellsouth.net                                                                                         
                                                                                                                      
                                                                                                                      
  github                                                                                                              
  https://tinyurl.com/y4hsqryz                                                                                        
  https://github.com/rogerjdeangelis/utl-set-each-element-of-an-array-to-zero-or-any-constant                         
                                                                                                                      
  SAS Forum                                                                                                           
  https://communities.sas.com/t5/user/viewprofilepage/user-id/32733                                                   
                                                                                                                      
  FreelanceReinhard                                                                                                   
  https://communities.sas.com/t5/user/viewprofilepage/user-id/32733                                                   
                                                                                                                      
  Related Repos                                                                                                       
  https://is.gd/tN59x8                                                                                                
  https://github.com/rogerjdeangelis/utl-obtain-the-sum-of-squared-elements-of-an-array-in-one-line                   
                                                                                                                      
  https://tinyurl.com/y38wbopq                                                                                        
  https://github.com/rogerjdeangelis/utl_datastep_array_row_col_reductions_sumOf                                      
                                                                                                                      
  macros                                                                                                              
  https://tinyurl.com/y9nfugth                                                                                        
  https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories                          
                                                                                                                      
                                                                                                                      
Set each element of an array to zero or any constant                                                                  
                                                                                                                      
                                                                                                                      
*                                         _                                                                           
  ___ ___  _ __ ___  _ __ ___   ___ _ __ | |_                                                                         
 / __/ _ \| '_ ` _ \| '_ ` _ \ / _ \ '_ \| __|                                                                        
| (_| (_) | | | | | | | | | | |  __/ | | | |_                                                                         
 \___\___/|_| |_| |_|_| |_| |_|\___|_| |_|\__|                                                                        
                                                                                                                      
;                                                                                                                     
                                                                                                                      
  Recent Sage advise from Paul Dorfman (applies to methods below)                                                     
                                                                                                                      
   1. The FCMP method calling FILLMATRIX is limited to the arrays                                                     
  satisfying all of the following conditions:                                                                         
                                                                                                                      
  - Temp.                                                                                                             
  - Numeric.                                                                                                          
  - Starting at index 1.                                                                                              
                                                                                                                      
  2. The APP method is good:                                                                                          
                                                                                                                      
  - For any temp array. I haven't found their addresses'                                                              
  contiguity to break for a temp array of any size.                                                                   
  - Any non-temp array, as long as it's the first thing                                                               
  the compiler sees, as this guarantees its addresses' contiguity.                                                    
                                                                                                                      
  One possible exception - discovered by Matt Kastin - is a                                                           
  non-temp character array so huge in size that the contiguity                                                        
  may get eventually broken somewhere down the line.                                                                  
  Methinks it doesn't matter in practice since I don't                                                                
  see how a non-temp array with millions of variables                                                                 
  can be of any practical utility. And at any rate,                                                                   
  I can't find any breaks even with 10 million items (takes a                                                         
  bout 2 minutes to compile/run):                                                                                     
                                                                                                                      
  data _null_ ;                                                                                                       
    array a [10000000] $ 7 ;                                                                                          
    contig = 1 ;                                                                                                      
    do i = 2 to dim (a) ;                                                                                             
      ap = addrlong (a[i-1]) ;                                                                                        
      ac = addrlong (a[i]) ;                                                                                          
      if ac = ptrlongadd (ap, vlength (a1)) then continue ;                                                           
      contig = 0 ;                                                                                                    
      leave ;                                                                                                         
    end ;                                                                                                             
    put contig= ;                                                                                                     
  run ;                                                                                                               
                                                                                                                      
  Best regards                                                                                                        
                                                                                                                      
*          _       _   _                                                                                              
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                              
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|                                                                             
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                             
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                             
                                                                                                                      
;                                                                                                                     
                                                                                                                      
*                     _ _       _      _ _                                                                            
  __ _       ___ __ _| | |  ___| |_ __| (_)_______                                                                    
 / _` |     / __/ _` | | | / __| __/ _` | |_  / _ \                                                                   
| (_| |_   | (_| (_| | | | \__ \ || (_| | |/ /  __/                                                                   
 \__,_(_)   \___\__,_|_|_| |___/\__\__,_|_/___\___|                                                                   
                                                                                                                      
;                                                                                                                     
                                                                                                                      
   data _null_;                                                                                                       
   array x[4] (2 3 5 7);                                                                                              
   call stdize('mult=',0,of x[*]);                                                                                    
   put x[*];                                                                                                          
   run;                                                                                                               
                                                                                                                      
                                                                                                                      
   If some (but not all) may be missing:                                                                              
                                                                                                                      
   data _null_;                                                                                                       
   array x[4] (2 3 . 7);                                                                                              
   call stdize('replace','mult=',0,of x[*]);                                                                          
   put x[*];                                                                                                          
   run;                                                                                                               
                                                                                                                      
   If you cannot rule out that all are missing:                                                                       
                                                                                                                      
   data _null_;                                                                                                       
   array x[4];                                                                                                        
   call stdize('replace','mult=',0,of x[*],_iorc_);                                                                   
   put x[*];                                                                                                          
   run;                                                                                                               
                                                                                                                      
                                                                                                                      
*_             _         _                                                                                            
| |__       __| | ___   | | ___   ___  _ __                                                                           
| '_ \     / _` |/ _ \  | |/ _ \ / _ \| '_ \                                                                          
| |_) |   | (_| | (_) | | | (_) | (_) | |_) |                                                                         
|_.__(_)   \__,_|\___/  |_|\___/ \___/| .__/                                                                          
                                      |_|                                                                             
;                                                                                                                     
                                                                                                                      
  Temporary and Permanent Datatep arrays of any size                                                                  
                                                                                                                      
           Classic method                                                                                             
           array mat[3] (4,4,4);                                                                                      
           do idx=1 to dim(mat);                                                                                      
              mat[i]=0;                                                                                               
           end;                                                                                                       
                                                                                                                      
                                                                                                                      
*                    _ _    __ _ _ _                 _        _                                                       
  ___       ___ __ _| | |  / _(_) | |_ __ ___   __ _| |_ _ __(_)_  __                                                 
 / __|     / __/ _` | | | | |_| | | | '_ ` _ \ / _` | __| '__| \ \/ /                                                 
| (__ _   | (_| (_| | | | |  _| | | | | | | | | (_| | |_| |  | |>  <                                                  
 \___(_)   \___\__,_|_|_| |_| |_|_|_|_| |_| |_|\__,_|\__|_|  |_/_/\_\                                                 
                                                                                                                      
;                                                                                                                     
                                                                                                                      
  Large Temporary Datastep Arrays  (temp arrays, numeric, starting index = 1 (Paul see above)                         
                                                                                                                      
           Very fast FCMP solution: Paul Dorfman sashole@bellsouth.net                                                
                                                                                                                      
           option cmplib=work.funcs ;                                                                                 
           proc fcmp outlib=work.funcs.test ;                                                                         
             subroutine fillarray (a[*], value) ;                                                                     
               outargs a ;                                                                                            
               call fillmatrix (a, value) ;                                                                           
             endsub ;                                                                                                 
           quit ;                                                                                                     
           data _null_ ;                                                                                              
             array q [1000000] _temporary_ (1000000*1);                                                               
             put "Before: " q[50000]=;                                                                                
             call fillarray (q, 0) ;                                                                                  
             put "After: " q[50000]=;                                                                                 
           run ;                                                                                                      
                                                                                                                      
           Before: Q[50000]=1                                                                                         
           After:  Q[50000]=0                                                                                         
                                                                                                                      
                                                                                                                      
*    _                                                         __ _ _                                                 
  __| |     _ __ ___   __ _  ___ _ __ ___     __ _ _ __ _   _ / _(_) |                                                
 / _` |    | '_ ` _ \ / _` |/ __| '__/ _ \   / _` | '__| | | | |_| | |                                                
| (_| |_   | | | | | | (_| | (__| | | (_) | | (_| | |  | |_| |  _| | |                                                
 \__,_(_)  |_| |_| |_|\__,_|\___|_|  \___/   \__,_|_|   \__, |_| |_|_|                                                
                                                        |___/                                                         
;                                                                                                                     
                                                                                                                      
  Samll Temporary or Permamnent Numeric Arrays ( < ~1000 elements) (macro on end)                                     
                                                                                                                      
           Array fill macro to each element                                                                           
                                                                                                                      
           data _null_;                                                                                               
             array mat[3] (3*1.57);                                                                                   
                                                                                                                      
             put "Before: " mat[2]=;                                                                                  
             %utl_aryFil(mat,3,fun=%str(*0));                                                                         
             put "After: " mat[2]=;                                                                                   
                                                                                                                      
             %utl_aryFil(mat,3,fun=cos);                                                                              
             put "After Sine Function: " mat[2]=;                                                                     
           run;quit;                                                                                                  
                                                                                                                      
           Before: MAT2=1.57                                                                                          
           After:  MAT2=0                                                                                             
           After Sine Function: MAT2=1 ==> sine of mat[2]                                                             
                                                                                                                      
*              _                                                                                                      
  ___       __| | ___     _____   _____ _ __                                                                          
 / _ \     / _` |/ _ \   / _ \ \ / / _ \ '__|                                                                         
|  __/_   | (_| | (_) | | (_) \ V /  __/ |                                                                            
 \___(_)   \__,_|\___/___\___/ \_/ \___|_|                                                                            
                    |_____|                                                                                           
;                                                                                                                     
           Macro do_over                                                                                              
                                                                                                                      
           data _null_;                                                                                               
              %array(mat,values=1-3);                                                                                 
              array mat[3] $1 (3*'X');                                                                                
              put "Before: " mat[*];                                                                                  
              %do_over(mat,phrase=%str(mat[?]="A";));                                                                 
              put "After: " mat[*];                                                                                   
           run;quit;                                                                                                  
                                                                                                                      
           Before: X X X                                                                                              
           After: A A A                                                                                               
                                                                                                                      
* __                 _        _                                                                                       
 / _|    _ __   ___ | | _____| | ___  _ __   __ _                                                                     
| |_    | '_ \ / _ \| |/ / _ \ |/ _ \| '_ \ / _` |                                                                    
|  _|   | |_) | (_) |   <  __/ | (_) | | | | (_| |                                                                    
|_|(_)  | .__/ \___/|_|\_\___|_|\___/|_| |_|\__, |                                                                    
        |_|                                 |___/                                                                     
;                                                                                                                     
                                                                                                                      
           Addrlong, pokelong  (Paul Dorfman sashole@bellsouth.net)  ( < ~4000 elements)                              
           Paul Dorfman sashole@bellsouth.net                                                                         
           https://listserv.uga.edu/cgi-bin/wa?A2=SAS-L;6ebe6aa1.1902d                                                
                                                                                                                      
           Should work with temporary and smaller permanent arrays                                                    
           (permanent arrys do no have back to back elements for larger arrays?)                                      
                                                                                                                      
           Data _null_;                                                                                               
              array mat [4000] _temporary_  (4000*1);                                                                 
              put "Before: " mat[2]=;                                                                                 
              length fill $ 32000 ;                                                                                   
              fill = repeat (put (0, rb8.), dim (mat) - 1) ;                                                          
              call pokelong (fill, addrlong (mat[1])) ;                                                               
              put "After: " mat[2]=;                                                                                  
           run;quit;                                                                                                  
                                                                                                                      
           Before: MAT[2]=1                                                                                           
           After:  MAT[2]=0                                                                                           
                                                                                                                      
                                                                                                                      
                                                                                                                      
