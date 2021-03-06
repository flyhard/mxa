/*
 * #%L
 * Service
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
package no.mxa.service.batch.confirmation;

import no.mxa.UniversalConstants.LogType;

public abstract class AbstractMessageAdapter implements MessageAdapter {

	@Override
	public final LogType getLogType() {
		if (isConfirmed()) {
			return LogType.MSG_CONFIRMED;
		}
		if (isRead()) {
			return LogType.MSG_READ;
		}
		return null;
	}

	public String getTypeString() {
		String type;
		if (isConfirmed()) {
			type = "Confirmed";
		} else if (isRead()) {
			type = "Read";
		} else {
			type = null;
		}
		return type;
	}

}
