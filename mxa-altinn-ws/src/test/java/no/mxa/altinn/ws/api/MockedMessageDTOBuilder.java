package no.mxa.altinn.ws.api;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.rowset.serial.SerialClob;
import javax.sql.rowset.serial.SerialException;

import no.mxa.dto.AttachmentDTO;
import no.mxa.dto.ContactInfoDTO;
import no.mxa.dto.MessageDTO;

/**
 * Provide {@link MessageDTO} test data.
 * 
 */
public class MockedMessageDTOBuilder {

	protected MessageDTO buildMessage() throws SerialException, SQLException {
		MessageDTO message = new MessageDTO();
		message.setParticipantId(getParticipantId());
		message.setMessageHeader(getMessageHeader());
		message.setMessageSummary(getMessageSummary());
		message.setAltinnArchive(getAltinnArchive());

		/** Attachments */
		List<AttachmentDTO> attachmentList = new ArrayList<AttachmentDTO>();
		attachmentList.add(buildAttachment(getFileName1()));
		attachmentList.add(buildAttachment(getFileName2()));
		message.setAttachments(attachmentList);

		/** ContactInfo */
		List<ContactInfoDTO> contactInfoList = new ArrayList<ContactInfoDTO>();
		contactInfoList.add(buildContactInfo("SMS", getPhoneNumber()));
		contactInfoList.add(buildContactInfo("EMAIL", getEmailAddress()));
		message.setContactInfo(contactInfoList);

		return message;
	}

	private AttachmentDTO buildAttachment(String fileName) throws SerialException, SQLException {
		AttachmentDTO attachment = new AttachmentDTO();
		attachment.setFileName(fileName);
		char[] clob = "TVhBLWRva3VtZW50IHRpbCBBbHR1dC4K".toCharArray();
		attachment.setAttachment(new SerialClob(clob));
		attachment.setAttachmentAsString(attachment.getAttachment().getSubString(1, clob.length));
		attachment.setName(getName());

		return attachment;
	}

	private ContactInfoDTO buildContactInfo(String type, String address) {
		ContactInfoDTO contactInfo = new ContactInfoDTO();
		contactInfo.setType(type);
		contactInfo.setAddress(address);

		return contactInfo;
	}

	protected String getGovOrgan() {
		return "SER";
	}

	protected String getParticipantId() {
		return "0101010101010";
	}

	protected String getLanguageCode() {
		return "1044";
	}

	protected String getMessageHeader() {
		return "Message header";
	}

	protected String getMessageSummary() {
		return "Message summary";
	}

	protected String getAltinnArchive() {
		return "AM1234";
	}

	protected String getFileName1() {
		return "File name 1";
	}

	protected String getFileName2() {
		return "File name 2";
	}

	protected String getName() {
		return "Name";
	}

	protected String getPhoneNumber() {
		return "12345678";
	}

	protected String getEmailAddress() {
		return "test@test.no";
	}

	protected String getSenderEmailAddress() {
		return "mxa@foo.bar";
	}

	protected String getNotificationType() {
		return "Correspondence";
	}

	protected String getServiceCode() {
		return "SER";
	}
	
	protected String getServiceEdition() {
		return "1";
	}

}
