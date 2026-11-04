.class public Lcom/amazonaws/auth/SessionCredentialsProviderFactory;
.super Ljava/lang/Object;
.source "SessionCredentialsProviderFactory.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/auth/SessionCredentialsProviderFactory$Key;
    }
.end annotation


# static fields
.field private static final cache:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lcom/amazonaws/auth/SessionCredentialsProviderFactory$Key;",
            "Lcom/amazonaws/auth/STSSessionCredentialsProvider;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 76
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/amazonaws/auth/SessionCredentialsProviderFactory;->cache:Ljava/util/Map;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized getSessionCredentialsProvider(Lcom/amazonaws/auth/AWSCredentials;Ljava/lang/String;Lcom/amazonaws/ClientConfiguration;)Lcom/amazonaws/auth/STSSessionCredentialsProvider;
    .locals 4
    .param p0, "longTermCredentials"    # Lcom/amazonaws/auth/AWSCredentials;
    .param p1, "serviceEndpoint"    # Ljava/lang/String;
    .param p2, "stsClientConfiguration"    # Lcom/amazonaws/ClientConfiguration;

    const-class v0, Lcom/amazonaws/auth/SessionCredentialsProviderFactory;

    monitor-enter v0

    .line 95
    :try_start_0
    new-instance v1, Lcom/amazonaws/auth/SessionCredentialsProviderFactory$Key;

    invoke-interface {p0}, Lcom/amazonaws/auth/AWSCredentials;->getAWSAccessKeyId()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, p1}, Lcom/amazonaws/auth/SessionCredentialsProviderFactory$Key;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 96
    .local v1, "key":Lcom/amazonaws/auth/SessionCredentialsProviderFactory$Key;
    sget-object v2, Lcom/amazonaws/auth/SessionCredentialsProviderFactory;->cache:Ljava/util/Map;

    invoke-interface {v2, v1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 97
    sget-object v2, Lcom/amazonaws/auth/SessionCredentialsProviderFactory;->cache:Ljava/util/Map;

    new-instance v3, Lcom/amazonaws/auth/STSSessionCredentialsProvider;

    invoke-direct {v3, p0, p2}, Lcom/amazonaws/auth/STSSessionCredentialsProvider;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/ClientConfiguration;)V

    invoke-interface {v2, v1, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 100
    :cond_0
    sget-object v2, Lcom/amazonaws/auth/SessionCredentialsProviderFactory;->cache:Ljava/util/Map;

    invoke-interface {v2, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/amazonaws/auth/STSSessionCredentialsProvider;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v2

    .line 94
    .end local v1    # "key":Lcom/amazonaws/auth/SessionCredentialsProviderFactory$Key;
    .end local p0    # "longTermCredentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local p1    # "serviceEndpoint":Ljava/lang/String;
    .end local p2    # "stsClientConfiguration":Lcom/amazonaws/ClientConfiguration;
    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method
