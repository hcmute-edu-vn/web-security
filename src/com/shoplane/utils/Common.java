package com.shoplane.utils;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class Common {
	public static EntityManager getEntityManager() {
		String connectionString = "shoplane-ft";
		EntityManagerFactory emf = Persistence.createEntityManagerFactory(connectionString);
		return emf.createEntityManager();
	}
}
