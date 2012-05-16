package no.mxa.ws.parser;

/**
 * Class for storing ContactInfo
 */
public class ContactInfo {

	private String type;
	private String address;

	public ContactInfo() {

	}

	public ContactInfo(String type, String address) {
		this.type = type;
		this.address = address;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}
