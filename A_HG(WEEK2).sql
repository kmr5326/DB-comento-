
INSERT INTO TEST03.TBL_LT_HIS
SELECT A.*
    FROM TEST01.TBL_LT_HIS A,
    TEST02.TBL_LT_HIS B
    WHERE A.FA_ID=B.FA_ID
        AND A.LT_ID = B.LT_ID
        AND A.PROD_ID=B.PROD_ID
        AND A.TIMEKEY = B.TIMEKEY
        AND A.STAT_TYP='RESERVE'
        AND B.STAT_TYP!='PROCESS'
UNION ALL
SELECT B.*
    FROM TEST01.TBL_LT_HIS A,
    TEST02.TBL_LT_HIS B
    WHERE A.FA_ID=B.FA_ID
        AND A.LT_ID = B.LT_ID
        AND A.PROD_ID=B.PROD_ID
        AND A.TIMEKEY = B.TIMEKEY
        AND A.STAT_TYP='RESERVE'
        AND B.STAT_TYP='PROCESS'
UNION ALL
SELECT * 
    FROM TEST01.TBL_LT_HIS A 
    WHERE NOT EXISTS ( 
               SELECT 1
                 FROM TEST02.TBL_LT_HIS B
                WHERE A.FA_ID = B.FA_ID
                  AND A.LT_ID = B.LT_ID
                  AND A.PROD_ID = B.PROD_ID
                  AND A.TIMEKEY = B.TIMEKEY
                  )
UNION ALL
SELECT * 
    FROM TEST02.TBL_LT_HIS B 
    WHERE NOT EXISTS ( 
               SELECT 1
                 FROM TEST01.TBL_LT_HIS A
                WHERE A.FA_ID = B.FA_ID
                  AND A.LT_ID = B.LT_ID
                  AND A.PROD_ID = B.PROD_ID
                  AND A.TIMEKEY = B.TIMEKEY
                  )