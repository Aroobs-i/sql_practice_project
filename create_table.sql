
Create Table transactions (
     step INT,
	 type Varchar(20),
	 amount numeric(15,2),
	 nameOrig Varchar(20),
	 oldbalanceOrig numeric(15,2),
	 newbalanceOrig numeric(15,2),
	 nameDest Varchar(20),
	 oldbalanceDest numeric(15,2),
	 newbalanceDest numeric(15,2),
	 isFraud smallint,
	 isFlaggedFraud smallint
);
