global class createLeadFromEmail implements Messaging.InboundEmailHandler
{
    //System.debug('@@@Inside My EmailServiceClass');
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope)
    {
       
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
         
        String subToCompare = 'CreateLeadFromEmailService';
        
        if(email.subject.equalsIgnoreCase(subToCompare))
        {
            Lead newLead = new Lead();
            
            newLead.LastName = email.plainTextBody;
            newLead.Company  = 'TCS';
            insert newLead;
            
            //Saving Attachments if Any
            
            for(Messaging.InboundEmail.TextAttachment tattachment : email.textAttachments)
            {
                Attachment attachment = new Attachment();
                
                attachment.Name     = tattachment.fileName;
                attachment.Body     = Blob.valueOf(tattachment.body);
                attachment.ParentId = newLead.Id;
                insert attachment;
            }
        }
        
        result.success = true;
        return result;
    }
}