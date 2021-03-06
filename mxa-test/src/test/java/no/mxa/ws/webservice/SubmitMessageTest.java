/*
 * #%L
 * Integration tests
 * %%
 * Copyright (C) 2009 - 2013 Patentstyret
 * %%
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of the 
 * License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public 
 * License along with this program.  If not, see
 * <http://www.gnu.org/licenses/gpl-3.0.html>.
 * #L%
 */
package no.mxa.ws.webservice;

import static org.junit.Assert.assertEquals;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.inject.Inject;

import no.mxa.dto.KeyValuesDTO;
import no.mxa.test.support.SpringBasedTest;
import no.mxa.test.support.TestDataHelper;

import org.junit.Before;
import org.junit.Test;
import org.springframework.core.io.ClassPathResource;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class SubmitMessageTest extends SpringBasedTest {

	@Inject
	private MXA mxa;
	private String xmlString;

	@Before
	public void setUp() throws IOException {
		ClassPathResource classPathResource = new ClassPathResource("agency_to_mxa/MessageExample.xml");
		InputStream is = classPathResource.getInputStream();
		BufferedReader reader = new BufferedReader(new InputStreamReader(is));
		StringBuilder sb = new StringBuilder();
		String line = null;
		try {
			while ((line = reader.readLine()) != null) {
				sb.append(line + "\n");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		is.close();
		reader.close();

		xmlString = sb.toString();

	}

	@Before
	public void setupDB() {
		TestDataHelper testDataHelper = new TestDataHelper(getDataSource());
		testDataHelper.insertKeyvalue(new KeyValuesDTO("MAILWARNDAYS", null, 14, null, null));
		testDataHelper.insertKeyvalue(new KeyValuesDTO("MAILNOTICEDAYS", null, 7, null, null));
	}

	@Test
	public void testSubmitMessage() {
		int returnCode = mxa.submitMessage(xmlString);
		assertEquals(0, returnCode);
	}
}
