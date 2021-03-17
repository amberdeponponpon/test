DECLARE
 l_ddl VARCHAR2(1000);

--実行日から30日前にロックされ、かつ現在もロックされているアカウントをソート 
 CURSOR tcur IS 
 SELECT * 
 FROM DBA_USERS  
 WHERE CREATED >= trunc(SYSDATE-30) AND CREATED < trunc(sysdate-29) AND ACCOUNT_STATUS = 'LOCKED';

 t2cur tcur%ROWTYPE;

--繰り返し処理。一度、l_ddl（文字列）に変数化して、各行処理で実行。
BEGIN
 OPEN tcur;
  LOOP
    FETCH tcur INTO t2cur;
    EXIT WHEN tcur%NOTFOUND;
      l_ddl := 'drop user '|| t2cur.username ||' cascade';
        dbms_output.put_line(l_ddl);
        EXECUTE IMMEDIATE (l_ddl);
  END LOOP;
 CLOSE tcur;
END;
/   