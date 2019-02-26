# utl-populate-or-operate-on-each-element-of-datastep-temporary-or-permanent-array
    Populate or operate on each element of datastep temporary or permanent array                                                     
                                                                                                                                     
      github                                                                                                                         
      https://tinyurl.com/yy8xpgd2                                                                                                   
      https://github.com/rogerjdeangelis/utl-populate-or-operate-on-each-element-of-datastep-temporary-or-permanent-array            
                                                                                                                                     
      Related Repos                                                                                                                  
      https://is.gd/tN59x8                                                                                                           
      https://github.com/rogerjdeangelis/utl-obtain-the-sum-of-squared-elements-of-an-array-in-one-line                              
                                                                                                                                     
      https://tinyurl.com/y38wbopq                                                                                                   
      https://github.com/rogerjdeangelis/utl_datastep_array_row_col_reductions_sumOf                                                 
                                                                                                                                     
      macros                                                                                                                         
      https://tinyurl.com/y9nfugth                                                                                                   
      https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories                                     
                                                                                                                                     
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
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
      Temporary and Permanent Datatep arrays of any size                                                                             
                                                                                                                                     
           1.  Classic method                                                                                                        
               array mat[3] (4,4,4);                                                                                                 
               do idx=1 to dim(mat);                                                                                                 
                  mat[i]=0;                                                                                                          
               end;                                                                                                                  
                                                                                                                                     
      Large Temporary Datastep Arrays  (temp arrays, numeric, starting index = 1 (Paul see above)                                    
                                                                                                                                     
           2.  Very fast FCMP solution: Paul Dorfman sashole@bellsouth.net                                                           
                                                                                                                                     
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
                                                                                                                                     
                                                                                                                                     
      Samll Temporary or Permamnent Numeric Arrays ( < ~1000 elements) (macro on end)                                                
                                                                                                                                     
           3.  Function to ally to each element                                                                                      
                                                                                                                                     
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
                                                                                                                                     
           4.  Macro do_over                                                                                                         
                                                                                                                                     
               data _null_;                                                                                                          
                  %array(mat,values=1-3);                                                                                            
                  array mat[3] $1 (3*'X');                                                                                           
                  put "Before: " mat[2]=;                                                                                            
                  %do_over(mat,phrase=%str(mat[?]="A";));                                                                            
                  put "After: " mat[2]=;                                                                                             
               run;quit;                                                                                                             
                                                                                                                                     
               Before: MAT2=X                                                                                                        
               After:  MAT2=A                                                                                                        
                                                                                                                                     
           5.  Second fastest?                                                                                                       
                                                                                                                                     
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
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
    %macro utl_aryFun(ary,len,fun=%str(**2))                                                                                         
      /des="sum an array after appling an arbitrary function to each element";                                                       
                                                                                                                                     
      %let rc=%sysfunc(dosubl('                                                                                                      
         data chk;                                                                                                                   
            length lst $32756;                                                                                                       
            do idx=1 to symgetn("len");                                                                                              
              if notalpha(substr(symget("fun"),1,1)) then                                                                            
                lst=catx(",",lst,cats("(",symget("ary"),"[",idx,"])",symget("fun")));                                                
            else                                                                                                                     
                lst=catx(",",lst,cats(symget("fun"),"(",symget("ary"),"[",idx,"])"));                                                
                                                                                                                                     
            end;                                                                                                                     
            call symputx("lst",lst,"G");                                                                                             
         run;quit;                                                                                                                   
         '));                                                                                                                        
      &lst                                                                                                                           
                                                                                                                                     
    %mend utl_aryFun;                                                                                                                
                                                                                                                                     
                                                                                                                                     
                                                                                                            
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
