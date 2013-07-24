/*
 * Copyright 2010-2012 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

#import "AmazonSESClient.h"
#import "../AmazonServiceRequest.h"


@implementation AmazonSESClient

-(id)initWithAccessKey:(NSString *)theAccessKey withSecretKey:(NSString *)theSecretKey
{
    if (self = [super initWithAccessKey:theAccessKey withSecretKey:theSecretKey]) {
        self.endpoint = @"https://email.us-east-1.amazonaws.com";
    }
    return self;
}

-(id)initWithCredentials:(AmazonCredentials *)theCredentials
{
    if (self = [super initWithCredentials:theCredentials]) {
        self.endpoint = @"https://email.us-east-1.amazonaws.com";
    }
    return self;
}

-(SESGetSendQuotaResponse *)getSendQuota:(SESGetSendQuotaRequest *)getSendQuotaRequest
{
    AmazonServiceRequest *request = [SESGetSendQuotaRequestMarshaller createRequest:getSendQuotaRequest];

    return (SESGetSendQuotaResponse *)[self invoke:request rawRequest:getSendQuotaRequest unmarshallerDelegate:[SESGetSendQuotaResponseUnmarshaller class]];
}

-(SESDeleteIdentityResponse *)deleteIdentity:(SESDeleteIdentityRequest *)deleteIdentityRequest
{
    AmazonServiceRequest *request = [SESDeleteIdentityRequestMarshaller createRequest:deleteIdentityRequest];

    return (SESDeleteIdentityResponse *)[self invoke:request rawRequest:deleteIdentityRequest unmarshallerDelegate:[SESDeleteIdentityResponseUnmarshaller class]];
}

-(SESListVerifiedEmailAddressesResponse *)listVerifiedEmailAddresses:(SESListVerifiedEmailAddressesRequest *)listVerifiedEmailAddressesRequest
{
    AmazonServiceRequest *request = [SESListVerifiedEmailAddressesRequestMarshaller createRequest:listVerifiedEmailAddressesRequest];

    return (SESListVerifiedEmailAddressesResponse *)[self invoke:request rawRequest:listVerifiedEmailAddressesRequest unmarshallerDelegate:[SESListVerifiedEmailAddressesResponseUnmarshaller class]];
}

-(SESGetSendStatisticsResponse *)getSendStatistics:(SESGetSendStatisticsRequest *)getSendStatisticsRequest
{
    AmazonServiceRequest *request = [SESGetSendStatisticsRequestMarshaller createRequest:getSendStatisticsRequest];

    return (SESGetSendStatisticsResponse *)[self invoke:request rawRequest:getSendStatisticsRequest unmarshallerDelegate:[SESGetSendStatisticsResponseUnmarshaller class]];
}

-(SESVerifyEmailIdentityResponse *)verifyEmailIdentity:(SESVerifyEmailIdentityRequest *)verifyEmailIdentityRequest
{
    AmazonServiceRequest *request = [SESVerifyEmailIdentityRequestMarshaller createRequest:verifyEmailIdentityRequest];

    return (SESVerifyEmailIdentityResponse *)[self invoke:request rawRequest:verifyEmailIdentityRequest unmarshallerDelegate:[SESVerifyEmailIdentityResponseUnmarshaller class]];
}

-(SESSendEmailResponse *)sendEmail:(SESSendEmailRequest *)sendEmailRequest
{
    AmazonServiceRequest *request = [SESSendEmailRequestMarshaller createRequest:sendEmailRequest];

    return (SESSendEmailResponse *)[self invoke:request rawRequest:sendEmailRequest unmarshallerDelegate:[SESSendEmailResponseUnmarshaller class]];
}

-(SESVerifyDomainIdentityResponse *)verifyDomainIdentity:(SESVerifyDomainIdentityRequest *)verifyDomainIdentityRequest
{
    AmazonServiceRequest *request = [SESVerifyDomainIdentityRequestMarshaller createRequest:verifyDomainIdentityRequest];

    return (SESVerifyDomainIdentityResponse *)[self invoke:request rawRequest:verifyDomainIdentityRequest unmarshallerDelegate:[SESVerifyDomainIdentityResponseUnmarshaller class]];
}

-(SESDeleteVerifiedEmailAddressResponse *)deleteVerifiedEmailAddress:(SESDeleteVerifiedEmailAddressRequest *)deleteVerifiedEmailAddressRequest
{
    AmazonServiceRequest *request = [SESDeleteVerifiedEmailAddressRequestMarshaller createRequest:deleteVerifiedEmailAddressRequest];

    return (SESDeleteVerifiedEmailAddressResponse *)[self invoke:request rawRequest:deleteVerifiedEmailAddressRequest unmarshallerDelegate:[SESDeleteVerifiedEmailAddressResponseUnmarshaller class]];
}

-(SESVerifyEmailAddressResponse *)verifyEmailAddress:(SESVerifyEmailAddressRequest *)verifyEmailAddressRequest
{
    AmazonServiceRequest *request = [SESVerifyEmailAddressRequestMarshaller createRequest:verifyEmailAddressRequest];

    return (SESVerifyEmailAddressResponse *)[self invoke:request rawRequest:verifyEmailAddressRequest unmarshallerDelegate:[SESVerifyEmailAddressResponseUnmarshaller class]];
}

-(SESSendRawEmailResponse *)sendRawEmail:(SESSendRawEmailRequest *)sendRawEmailRequest
{
    AmazonServiceRequest *request = [SESSendRawEmailRequestMarshaller createRequest:sendRawEmailRequest];

    return (SESSendRawEmailResponse *)[self invoke:request rawRequest:sendRawEmailRequest unmarshallerDelegate:[SESSendRawEmailResponseUnmarshaller class]];
}

-(SESListIdentitiesResponse *)listIdentities:(SESListIdentitiesRequest *)listIdentitiesRequest
{
    AmazonServiceRequest *request = [SESListIdentitiesRequestMarshaller createRequest:listIdentitiesRequest];

    return (SESListIdentitiesResponse *)[self invoke:request rawRequest:listIdentitiesRequest unmarshallerDelegate:[SESListIdentitiesResponseUnmarshaller class]];
}

-(SESGetIdentityVerificationAttributesResponse *)getIdentityVerificationAttributes:(SESGetIdentityVerificationAttributesRequest *)getIdentityVerificationAttributesRequest
{
    AmazonServiceRequest *request = [SESGetIdentityVerificationAttributesRequestMarshaller createRequest:getIdentityVerificationAttributesRequest];

    return (SESGetIdentityVerificationAttributesResponse *)[self invoke:request rawRequest:getIdentityVerificationAttributesRequest unmarshallerDelegate:[SESGetIdentityVerificationAttributesResponseUnmarshaller class]];
}



@end

