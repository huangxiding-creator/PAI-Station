.class public Lcom/amazonaws/auth/STSSessionCredentials;
.super Ljava/lang/Object;
.source "STSSessionCredentials.java"

# interfaces
.implements Lcom/amazonaws/auth/AWSRefreshableSessionCredentials;


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field public static final DEFAULT_DURATION_SECONDS:I = 0xe10


# instance fields
.field private final securityTokenService:Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;

.field private sessionCredentials:Lcom/amazonaws/services/securitytoken/model/Credentials;

.field private final sessionDurationSeconds:I


# direct methods
.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;)V
    .locals 1
    .param p1, "credentials"    # Lcom/amazonaws/auth/AWSCredentials;

    .line 57
    const/16 v0, 0xe10

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/auth/STSSessionCredentials;-><init>(Lcom/amazonaws/auth/AWSCredentials;I)V

    .line 58
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;I)V
    .locals 1
    .param p1, "credentials"    # Lcom/amazonaws/auth/AWSCredentials;
    .param p2, "sessionDurationSeconds"    # I

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    new-instance v0, Lcom/amazonaws/services/securitytoken/AWSSecurityTokenServiceClient;

    invoke-direct {v0, p1}, Lcom/amazonaws/services/securitytoken/AWSSecurityTokenServiceClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;)V

    iput-object v0, p0, Lcom/amazonaws/auth/STSSessionCredentials;->securityTokenService:Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;

    .line 70
    iput p2, p0, Lcom/amazonaws/auth/STSSessionCredentials;->sessionDurationSeconds:I

    .line 71
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;)V
    .locals 1
    .param p1, "stsClient"    # Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;

    .line 81
    const/16 v0, 0xe10

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/auth/STSSessionCredentials;-><init>(Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;I)V

    .line 82
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;I)V
    .locals 0
    .param p1, "stsClient"    # Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;
    .param p2, "sessionDuratinSeconds"    # I

    .line 92
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 93
    iput-object p1, p0, Lcom/amazonaws/auth/STSSessionCredentials;->securityTokenService:Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;

    .line 94
    iput p2, p0, Lcom/amazonaws/auth/STSSessionCredentials;->sessionDurationSeconds:I

    .line 95
    return-void
.end method

.method private declared-synchronized getSessionCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;
    .locals 1

    monitor-enter p0

    .line 161
    :try_start_0
    invoke-direct {p0}, Lcom/amazonaws/auth/STSSessionCredentials;->needsNewSession()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 162
    invoke-virtual {p0}, Lcom/amazonaws/auth/STSSessionCredentials;->refreshCredentials()V

    .line 163
    .end local p0    # "this":Lcom/amazonaws/auth/STSSessionCredentials;
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/auth/STSSessionCredentials;->sessionCredentials:Lcom/amazonaws/services/securitytoken/model/Credentials;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 160
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private needsNewSession()Z
    .locals 6

    .line 167
    iget-object v0, p0, Lcom/amazonaws/auth/STSSessionCredentials;->sessionCredentials:Lcom/amazonaws/services/securitytoken/model/Credentials;

    const/4 v1, 0x1

    if-nez v0, :cond_0

    .line 168
    return v1

    .line 170
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/auth/STSSessionCredentials;->sessionCredentials:Lcom/amazonaws/services/securitytoken/model/Credentials;

    invoke-virtual {v0}, Lcom/amazonaws/services/securitytoken/model/Credentials;->getExpiration()Ljava/util/Date;

    move-result-object v0

    .line 171
    .local v0, "expiration":Ljava/util/Date;
    invoke-virtual {v0}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    sub-long/2addr v2, v4

    .line 172
    .local v2, "timeRemaining":J
    const-wide/32 v4, 0xea60

    cmp-long v4, v2, v4

    if-gez v4, :cond_1

    .line 173
    return v1

    .line 175
    :cond_1
    const/4 v1, 0x0

    return v1
.end method


# virtual methods
.method public declared-synchronized getAWSAccessKeyId()Ljava/lang/String;
    .locals 1

    monitor-enter p0

    .line 107
    :try_start_0
    invoke-direct {p0}, Lcom/amazonaws/auth/STSSessionCredentials;->getSessionCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/services/securitytoken/model/Credentials;->getAccessKeyId()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 107
    .end local p0    # "this":Lcom/amazonaws/auth/STSSessionCredentials;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getAWSSecretKey()Ljava/lang/String;
    .locals 1

    monitor-enter p0

    .line 120
    :try_start_0
    invoke-direct {p0}, Lcom/amazonaws/auth/STSSessionCredentials;->getSessionCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/services/securitytoken/model/Credentials;->getSecretAccessKey()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 120
    .end local p0    # "this":Lcom/amazonaws/auth/STSSessionCredentials;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getImmutableCredentials()Lcom/amazonaws/auth/AWSSessionCredentials;
    .locals 5

    monitor-enter p0

    .line 141
    :try_start_0
    invoke-direct {p0}, Lcom/amazonaws/auth/STSSessionCredentials;->getSessionCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v0

    .line 142
    .local v0, "creds":Lcom/amazonaws/services/securitytoken/model/Credentials;
    new-instance v1, Lcom/amazonaws/auth/BasicSessionCredentials;

    invoke-virtual {v0}, Lcom/amazonaws/services/securitytoken/model/Credentials;->getAccessKeyId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lcom/amazonaws/services/securitytoken/model/Credentials;->getSecretAccessKey()Ljava/lang/String;

    move-result-object v3

    .line 143
    invoke-virtual {v0}, Lcom/amazonaws/services/securitytoken/model/Credentials;->getSessionToken()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v2, v3, v4}, Lcom/amazonaws/auth/BasicSessionCredentials;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 142
    monitor-exit p0

    return-object v1

    .line 140
    .end local v0    # "creds":Lcom/amazonaws/services/securitytoken/model/Credentials;
    .end local p0    # "this":Lcom/amazonaws/auth/STSSessionCredentials;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getSessionToken()Ljava/lang/String;
    .locals 1

    monitor-enter p0

    .line 133
    :try_start_0
    invoke-direct {p0}, Lcom/amazonaws/auth/STSSessionCredentials;->getSessionCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/services/securitytoken/model/Credentials;->getSessionToken()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 133
    .end local p0    # "this":Lcom/amazonaws/auth/STSSessionCredentials;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized refreshCredentials()V
    .locals 3

    monitor-enter p0

    .line 151
    :try_start_0
    iget-object v0, p0, Lcom/amazonaws/auth/STSSessionCredentials;->securityTokenService:Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;

    new-instance v1, Lcom/amazonaws/services/securitytoken/model/GetSessionTokenRequest;

    invoke-direct {v1}, Lcom/amazonaws/services/securitytoken/model/GetSessionTokenRequest;-><init>()V

    iget v2, p0, Lcom/amazonaws/auth/STSSessionCredentials;->sessionDurationSeconds:I

    .line 153
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/amazonaws/services/securitytoken/model/GetSessionTokenRequest;->withDurationSeconds(Ljava/lang/Integer;)Lcom/amazonaws/services/securitytoken/model/GetSessionTokenRequest;

    move-result-object v1

    .line 152
    invoke-interface {v0, v1}, Lcom/amazonaws/services/securitytoken/AWSSecurityTokenService;->getSessionToken(Lcom/amazonaws/services/securitytoken/model/GetSessionTokenRequest;)Lcom/amazonaws/services/securitytoken/model/GetSessionTokenResult;

    move-result-object v0

    .line 154
    .local v0, "sessionTokenResult":Lcom/amazonaws/services/securitytoken/model/GetSessionTokenResult;
    invoke-virtual {v0}, Lcom/amazonaws/services/securitytoken/model/GetSessionTokenResult;->getCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v1

    iput-object v1, p0, Lcom/amazonaws/auth/STSSessionCredentials;->sessionCredentials:Lcom/amazonaws/services/securitytoken/model/Credentials;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 155
    monitor-exit p0

    return-void

    .line 150
    .end local v0    # "sessionTokenResult":Lcom/amazonaws/services/securitytoken/model/GetSessionTokenResult;
    .end local p0    # "this":Lcom/amazonaws/auth/STSSessionCredentials;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
