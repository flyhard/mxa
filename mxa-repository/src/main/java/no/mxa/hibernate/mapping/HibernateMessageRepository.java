package no.mxa.hibernate.mapping;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import no.mxa.UniversalConstants;
import no.mxa.dataaccess.MessageRepository;
import no.mxa.dto.MessageDTO;
import no.mxa.utils.hibernate.BaseHibernateRepository;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 * HibernateRepository class for Message
 */
public class HibernateMessageRepository extends BaseHibernateRepository<MessageDTO> implements MessageRepository {

	private static final Integer MAX_WARN_MESSAGE_STATUS = 41;

	/**
	 * 
	 * @param sessionFactory
	 *            the session creation object
	 */
	public HibernateMessageRepository(SessionFactory sessionFactory) {
		super(sessionFactory);
	}

	/**
	 * @return class name
	 */
	public String getDtoClassName() {
		return MessageDTO.class.getName();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MessageDTO> findByExample(MessageDTO instance) {
		return getSessionFactory().getCurrentSession().createCriteria(getDtoClassName()).add(Example.create(instance))
				.addOrder(Order.desc("sentAltinnDate")).setMaxResults(100).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MessageDTO> findByProperty(String propertyName, Object value) {
		String queryString = "from " + getDtoClassName() + " as model where model." + propertyName + "= ?"
				+ " ORDER BY sentaltinndate desc";
		Query queryObject = getSessionFactory().getCurrentSession().createQuery(queryString);
		queryObject.setParameter(0, value);
		return queryObject.setMaxResults(100).list();
	}

	@SuppressWarnings({ "unchecked" })
	public List<MessageDTO> findDeviations(Date presentDate) {
		Criteria deviationsCriteria = (getSessionFactory().getCurrentSession().createCriteria(this.getDtoClassName()));

		Criterion notFailed = Restrictions.ne("messageStatus", UniversalConstants.MSG_STATUS_SEND_ALTINN_FAILED);
		Criterion notRead = Restrictions.ne("messageStatus", UniversalConstants.MSG_STATUS_READ_IN_ALTINN);
		Criterion notConfirmed = Restrictions.lt("messageStatus", UniversalConstants.MSG_STATUS_CONFIRMED_IN_ALTINN);
		Criterion lessThanPresentDate = Restrictions.lt("readDeadline", presentDate);
		Criterion failed = Restrictions.eq("messageStatus", UniversalConstants.MSG_STATUS_SEND_ALTINN_FAILED);

		List<MessageDTO> messagesWithDeviations = deviationsCriteria
				.add(Restrictions.or(Restrictions.and(Restrictions.and(Restrictions.and(notRead, notFailed), notConfirmed),
						lessThanPresentDate), failed)).addOrder(Order.desc("sentAltinnDate")).setMaxResults(100).list();

		return messagesWithDeviations;
	}

	@SuppressWarnings("unchecked")
	public List<MessageDTO> findByCriteriaFromGUI(MessageDTO criteria, Date fromDate, Date toDate, String caseDescription,
			String messageReference) {
		Criteria criteriaToBuild = buildCriteria(criteria, caseDescription, messageReference);
		List<MessageDTO> returnList = null;
		// Add 24 hours to include toDate in search
		Long numberOfMilliSecondsInTwentyFourHours = 0L + (24 * 60 * 60 * 1000);

		// Return different lists based on input values
		if (fromDate == null && toDate == null) {
			returnList = criteriaToBuild.addOrder(Order.desc("sentAltinnDate")).setMaxResults(100).list();
		} else if (fromDate != null && toDate == null) {
			returnList = addDateRestrictionsOnFromDateAndReturnList(criteriaToBuild, fromDate.getTime());
		} else if (fromDate == null && toDate != null) {
			returnList = addDateRestrictionsOnToDateAndReturnList(criteriaToBuild, toDate.getTime()
					+ numberOfMilliSecondsInTwentyFourHours);
		} else if (fromDate != null && toDate != null) {
			returnList = addDateRestrictionsOnFromDateAndToDateAndReturnList(criteriaToBuild, fromDate.getTime(),
					toDate.getTime() + numberOfMilliSecondsInTwentyFourHours);
		}

		return returnList;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<MessageDTO> findNoticeMessages(Date presentDate) {
		return (getSessionFactory().getCurrentSession().createCriteria(this.getDtoClassName())
				.add(Restrictions.eq("overdueNoticeSent", UniversalConstants.MSG_OVERDUENOTICE_FALSE))
				.add(Restrictions.lt("readDeadline", presentDate))
				.add(Restrictions.ne("messageStatus", UniversalConstants.MSG_STATUS_SEND_ALTINN_FAILED))
				.add(Restrictions.ne("messageStatus", UniversalConstants.MSG_STATUS_READ_IN_ALTINN)).add(Restrictions.lt(
				"messageStatus", MAX_WARN_MESSAGE_STATUS))).list();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<MessageDTO> findWarnMessages(Date presentDate) {
		return (getSessionFactory().getCurrentSession().createCriteria(this.getDtoClassName())
				.add(Restrictions.eq("overdueNoticeSent", UniversalConstants.MSG_OVERDUENOTICE_TRUE))
				.add(Restrictions.lt("readDeadline", presentDate))
				.add(Restrictions.ne("messageStatus", UniversalConstants.MSG_STATUS_SEND_ALTINN_FAILED))
				.add(Restrictions.ne("messageStatus", UniversalConstants.MSG_STATUS_READ_IN_ALTINN)).add(Restrictions.lt(
				"messageStatus", MAX_WARN_MESSAGE_STATUS))).list();
	}

	private Criteria buildCriteria(MessageDTO criteria, String caseDescription, String messageReference) {
		Criteria criteriaToBuild = (getSessionFactory().getCurrentSession().createCriteria(this.getDtoClassName()).add(Example
				.create(criteria).ignoreCase()));
		if (caseDescription != null && caseDescription.length() > 0) {
			criteriaToBuild.add(Restrictions.like("caseDescription", caseDescription, MatchMode.ANYWHERE).ignoreCase());
		}

		if (messageReference != null && messageReference.length() > 0) {
			criteriaToBuild.add(Restrictions.like("messageReference", messageReference, MatchMode.ANYWHERE).ignoreCase());
		}

		return criteriaToBuild;
	}

	@SuppressWarnings("unchecked")
	private List<MessageDTO> addDateRestrictionsOnFromDateAndReturnList(Criteria criteria, Long fromDateTime) {
		return criteria.add(Restrictions.gt("sentAltinnDate", new Timestamp(fromDateTime)))
				.addOrder(Order.desc("sentAltinnDate")).setMaxResults(100).list();
	}

	@SuppressWarnings("unchecked")
	private List<MessageDTO> addDateRestrictionsOnToDateAndReturnList(Criteria criteria, Long toDateTime) {
		return criteria.add(Restrictions.lt("sentAltinnDate", new Timestamp(toDateTime)))
				.addOrder(Order.desc("sentAltinnDate")).setMaxResults(100).list();
	}

	@SuppressWarnings("unchecked")
	private List<MessageDTO> addDateRestrictionsOnFromDateAndToDateAndReturnList(Criteria criteria, Long fromDateTime,
			Long toDateTime) {
		return criteria.add(Restrictions.between("sentAltinnDate", new Timestamp(fromDateTime), new Timestamp(toDateTime)))
				.addOrder(Order.desc("sentAltinnDate")).setMaxResults(100).list();
	}

}
