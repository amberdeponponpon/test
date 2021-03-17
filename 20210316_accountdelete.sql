DECLARE
 l_ddl VARCHAR2(1000);

--���s������30���O�Ƀ��b�N����A�����݂����b�N����Ă���A�J�E���g���\�[�g 
 CURSOR tcur IS 
 SELECT * 
 FROM DBA_USERS  
 WHERE CREATED >= trunc(SYSDATE-30) AND CREATED < trunc(sysdate-29) AND ACCOUNT_STATUS = 'LOCKED';

 t2cur tcur%ROWTYPE;

--�J��Ԃ������B��x�Al_ddl�i������j�ɕϐ������āA�e�s�����Ŏ��s�B
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