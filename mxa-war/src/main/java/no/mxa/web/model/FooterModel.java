/*
 * #%L
 * Web Archive
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
package no.mxa.web.model;

import java.text.DateFormat;
import java.util.Date;

/**
 * Provides data to the footer div.
 */
public class FooterModel {
	private String developedBy;
	private String version;

	public FooterModel(String version) {
		this.version = version;
		developedBy = "Applikasjonen ble sist startet: " + DateFormat.getDateInstance().format(new Date());
	}

	public String getDevelopedBy() {
		return developedBy;
	}

	public String getVersion() {
		return version;
	}
}
