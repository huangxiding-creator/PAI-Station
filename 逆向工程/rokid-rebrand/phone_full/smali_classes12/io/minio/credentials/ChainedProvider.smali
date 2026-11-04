.class public Lio/minio/credentials/ChainedProvider;
.super Ljava/lang/Object;
.source "ChainedProvider.java"

# interfaces
.implements Lio/minio/credentials/Provider;


# instance fields
.field private credentials:Lio/minio/credentials/Credentials;

.field private currentProvider:Lio/minio/credentials/Provider;

.field private final providers:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/credentials/Provider;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public varargs constructor <init>([Lio/minio/credentials/Provider;)V
    .locals 1
    .param p1, "providers"    # [Lio/minio/credentials/Provider;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lio/minio/credentials/ChainedProvider;->providers:Ljava/util/List;

    .line 33
    return-void
.end method


# virtual methods
.method public declared-synchronized fetch()Lio/minio/credentials/Credentials;
    .locals 3

    monitor-enter p0

    .line 37
    :try_start_0
    iget-object v0, p0, Lio/minio/credentials/ChainedProvider;->credentials:Lio/minio/credentials/Credentials;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/credentials/ChainedProvider;->credentials:Lio/minio/credentials/Credentials;

    invoke-virtual {v0}, Lio/minio/credentials/Credentials;->isExpired()Z

    move-result v0

    if-nez v0, :cond_0

    .line 38
    iget-object v0, p0, Lio/minio/credentials/ChainedProvider;->credentials:Lio/minio/credentials/Credentials;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 41
    .end local p0    # "this":Lio/minio/credentials/ChainedProvider;
    :cond_0
    :try_start_1
    iget-object v0, p0, Lio/minio/credentials/ChainedProvider;->currentProvider:Lio/minio/credentials/Provider;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v0, :cond_1

    .line 43
    :try_start_2
    iget-object v0, p0, Lio/minio/credentials/ChainedProvider;->currentProvider:Lio/minio/credentials/Provider;

    invoke-interface {v0}, Lio/minio/credentials/Provider;->fetch()Lio/minio/credentials/Credentials;

    move-result-object v0

    iput-object v0, p0, Lio/minio/credentials/ChainedProvider;->credentials:Lio/minio/credentials/Credentials;

    .line 44
    iget-object v0, p0, Lio/minio/credentials/ChainedProvider;->credentials:Lio/minio/credentials/Credentials;
    :try_end_2
    .catch Ljava/security/ProviderException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit p0

    return-object v0

    .line 45
    :catch_0
    move-exception v0

    .line 50
    :cond_1
    :try_start_3
    iget-object v0, p0, Lio/minio/credentials/ChainedProvider;->providers:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/minio/credentials/Provider;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 52
    .local v1, "provider":Lio/minio/credentials/Provider;
    :try_start_4
    invoke-interface {v1}, Lio/minio/credentials/Provider;->fetch()Lio/minio/credentials/Credentials;

    move-result-object v2

    iput-object v2, p0, Lio/minio/credentials/ChainedProvider;->credentials:Lio/minio/credentials/Credentials;

    .line 53
    iput-object v1, p0, Lio/minio/credentials/ChainedProvider;->currentProvider:Lio/minio/credentials/Provider;

    .line 54
    iget-object v0, p0, Lio/minio/credentials/ChainedProvider;->credentials:Lio/minio/credentials/Credentials;
    :try_end_4
    .catch Ljava/security/ProviderException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    monitor-exit p0

    return-object v0

    .line 55
    :catch_1
    move-exception v2

    .line 58
    .end local v1    # "provider":Lio/minio/credentials/Provider;
    goto :goto_0

    .line 60
    :cond_2
    :try_start_5
    new-instance v0, Ljava/security/ProviderException;

    const-string v1, "All providers fail to fetch credentials"

    invoke-direct {v0, v1}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 36
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
