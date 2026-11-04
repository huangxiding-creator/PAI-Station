.class public Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;
.super Ljava/lang/Object;
.source "WebIdentityFederationSessionCredentialsProvider.java"

# interfaces
.implements Lcom/amazonaws/auth/AWSCredentialsProvider;


# static fields
.field public static final DEFAULT_DURATION_SECONDS:I = 0xe10

.field public static final DEFAULT_THRESHOLD_SECONDS:I = 0x1f4


# instance fields
.field private refreshThreshold:I

.field private final roleArn:Ljava/lang/String;

.field private final securityTokenService:Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;

.field private sessionCredentials:Lcom/amazonaws/auth/AWSSessionCredentials;

.field private sessionCredentialsExpiration:Ljava/util/Date;

.field private sessionDuration:I

.field private subjectFromWIF:Ljava/lang/String;

.field private final wifProvider:Ljava/lang/String;

.field private final wifToken:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "wifToken"    # Ljava/lang/String;
    .param p2, "wifProvider"    # Ljava/lang/String;
    .param p3, "roleArn"    # Ljava/lang/String;

    .line 69
    new-instance v0, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v0}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, p1, p2, p3, v0}, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/ClientConfiguration;)V

    .line 70
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/ClientConfiguration;)V
    .locals 2
    .param p1, "wifToken"    # Ljava/lang/String;
    .param p2, "wifProvider"    # Ljava/lang/String;
    .param p3, "roleArn"    # Ljava/lang/String;
    .param p4, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;

    .line 87
    new-instance v0, Lcom/amazonaws/services/securitytoken/AWSSecurityTokenServiceClient;

    new-instance v1, Lcom/amazonaws/auth/AnonymousAWSCredentials;

    invoke-direct {v1}, Lcom/amazonaws/auth/AnonymousAWSCredentials;-><init>()V

    invoke-direct {v0, v1, p4}, Lcom/amazonaws/services/securitytoken/AWSSecurityTokenServiceClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/ClientConfiguration;)V

    invoke-direct {p0, p1, p2, p3, v0}, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;)V

    .line 89
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;)V
    .locals 1
    .param p1, "wifToken"    # Ljava/lang/String;
    .param p2, "wifProvider"    # Ljava/lang/String;
    .param p3, "roleArn"    # Ljava/lang/String;
    .param p4, "stsClient"    # Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;

    .line 105
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 106
    iput-object p4, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->securityTokenService:Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;

    .line 107
    iput-object p2, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->wifProvider:Ljava/lang/String;

    .line 108
    iput-object p1, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->wifToken:Ljava/lang/String;

    .line 109
    iput-object p3, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->roleArn:Ljava/lang/String;

    .line 110
    const/16 v0, 0xe10

    iput v0, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->sessionDuration:I

    .line 111
    const/16 v0, 0x1f4

    iput v0, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->refreshThreshold:I

    .line 112
    return-void
.end method

.method private needsNewSession()Z
    .locals 6

    .line 253
    iget-object v0, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->sessionCredentials:Lcom/amazonaws/auth/AWSSessionCredentials;

    const/4 v1, 0x1

    if-nez v0, :cond_0

    .line 254
    return v1

    .line 256
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->sessionCredentialsExpiration:Ljava/util/Date;

    invoke-virtual {v0}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    sub-long/2addr v2, v4

    .line 257
    .local v2, "timeRemaining":J
    iget v0, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->refreshThreshold:I

    mul-int/lit16 v0, v0, 0x3e8

    int-to-long v4, v0

    cmp-long v0, v2, v4

    if-gez v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method private startSession()V
    .locals 6

    .line 227
    iget-object v0, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->securityTokenService:Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;

    new-instance v1, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;

    invoke-direct {v1}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;-><init>()V

    iget-object v2, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->wifToken:Ljava/lang/String;

    .line 229
    invoke-virtual {v1, v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;->withWebIdentityToken(Ljava/lang/String;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;

    move-result-object v1

    iget-object v2, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->wifProvider:Ljava/lang/String;

    .line 230
    invoke-virtual {v1, v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;->withProviderId(Ljava/lang/String;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;

    move-result-object v1

    iget-object v2, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->roleArn:Ljava/lang/String;

    .line 231
    invoke-virtual {v1, v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;->withRoleArn(Ljava/lang/String;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;

    move-result-object v1

    .line 232
    const-string v2, "ProviderSession"

    invoke-virtual {v1, v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;->withRoleSessionName(Ljava/lang/String;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;

    move-result-object v1

    iget v2, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->sessionDuration:I

    .line 233
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;->withDurationSeconds(Ljava/lang/Integer;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;

    move-result-object v1

    .line 228
    invoke-interface {v0, v1}, Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;->assumeRoleWithWebIdentity(Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityRequest;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityResult;

    move-result-object v0

    .line 234
    .local v0, "sessionTokenResult":Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityResult;
    invoke-virtual {v0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityResult;->getCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v1

    .line 236
    .local v1, "stsCredentials":Lcom/amazonaws/services/securitytoken/model/Credentials;
    invoke-virtual {v0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithWebIdentityResult;->getSubjectFromWebIdentityToken()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->subjectFromWIF:Ljava/lang/String;

    .line 238
    new-instance v2, Lcom/amazonaws/auth/BasicSessionCredentials;

    .line 239
    invoke-virtual {v1}, Lcom/amazonaws/services/securitytoken/model/Credentials;->getAccessKeyId()Ljava/lang/String;

    move-result-object v3

    .line 240
    invoke-virtual {v1}, Lcom/amazonaws/services/securitytoken/model/Credentials;->getSecretAccessKey()Ljava/lang/String;

    move-result-object v4

    .line 241
    invoke-virtual {v1}, Lcom/amazonaws/services/securitytoken/model/Credentials;->getSessionToken()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v2, v3, v4, v5}, Lcom/amazonaws/auth/BasicSessionCredentials;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iput-object v2, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->sessionCredentials:Lcom/amazonaws/auth/AWSSessionCredentials;

    .line 242
    invoke-virtual {v1}, Lcom/amazonaws/services/securitytoken/model/Credentials;->getExpiration()Ljava/util/Date;

    move-result-object v2

    iput-object v2, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->sessionCredentialsExpiration:Ljava/util/Date;

    .line 243
    return-void
.end method


# virtual methods
.method public getCredentials()Lcom/amazonaws/auth/AWSCredentials;
    .locals 1

    .line 116
    invoke-direct {p0}, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->needsNewSession()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 117
    invoke-direct {p0}, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->startSession()V

    .line 119
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->sessionCredentials:Lcom/amazonaws/auth/AWSSessionCredentials;

    return-object v0
.end method

.method public getRefreshThreshold()I
    .locals 1

    .line 206
    iget v0, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->refreshThreshold:I

    return v0
.end method

.method public getSessionDuration()I
    .locals 1

    .line 163
    iget v0, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->sessionDuration:I

    return v0
.end method

.method public getSubjectFromWIF()Ljava/lang/String;
    .locals 1

    .line 218
    iget-object v0, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->subjectFromWIF:Ljava/lang/String;

    return-object v0
.end method

.method public refresh()V
    .locals 0

    .line 124
    invoke-direct {p0}, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->startSession()V

    .line 125
    return-void
.end method

.method public setRefreshThreshold(I)V
    .locals 0
    .param p1, "refreshThreshold"    # I

    .line 176
    iput p1, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->refreshThreshold:I

    .line 177
    return-void
.end method

.method public setSessionDuration(I)V
    .locals 0
    .param p1, "sessionDuration"    # I

    .line 136
    iput p1, p0, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->sessionDuration:I

    .line 137
    return-void
.end method

.method public withRefreshThreshold(I)Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;
    .locals 0
    .param p1, "refreshThreshold"    # I

    .line 192
    invoke-virtual {p0, p1}, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->setRefreshThreshold(I)V

    .line 193
    return-object p0
.end method

.method public withSessionDuration(I)Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;
    .locals 0
    .param p1, "sessionDuration"    # I

    .line 151
    invoke-virtual {p0, p1}, Lcom/amazonaws/auth/WebIdentityFederationSessionCredentialsProvider;->setSessionDuration(I)V

    .line 152
    return-object p0
.end method
