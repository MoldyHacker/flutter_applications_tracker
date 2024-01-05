
enum ActionType {
  submitted,              // Indicates the job application has been submitted.
  followedUp,             // Used when the applicant has followed up on an application, typically after not hearing back for a while.
  interviewScheduled,     // Marks when an interview has been arranged.
  interviewCompleted,     // Indicates that the interview has taken place.
  receivedFeedback,       // Used when the applicant receives feedback from the employer, whether positive or negative.
  offerReceived,          // Indicates that the applicant has received a job offer.
  offerAccepted,          // Used when the applicant accepts a job offer.
  offerDeclined,          // Indicates that the applicant has declined a job offer.
  rejected,               // Marks the application as rejected by the employer.
  withdrawn,              // Used when the applicant decides to withdraw their application.
  networkingContactMade,  // Indicates networking or contact made for potential opportunities, which is common in the IT field.
  referralRequested,      // If the applicant has requested a referral from a contact.
  portfolioSent,          // Specific to IT and related fields, indicating that the applicant has sent their portfolio or work samples.
  technicalTestCompleted, // Marks the completion of a technical test or coding challenge, often a part of the IT job application process.
  awaitingResponse,       // Indicates that the applicant is waiting for a response after an interview or other significant action.
}

class Action {
  final String id;
  final String applicationId;
  final ActionType actionType;
  final DateTime date;
  final String? description;
  final String? result;

  Action({
    required this.id,
    required this.applicationId,
    required this.actionType,
    required this.date,
    this.description,
    this.result,
  });
}