.class public Lio/minio/credentials/Credentials;
.super Ljava/lang/Object;
.source "Credentials.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Credentials"
    strict = false
.end annotation


# instance fields
.field private final accessKey:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "AccessKeyId"
    .end annotation
.end field

.field private final expiration:Lio/minio/messages/ResponseDate;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Expiration"
    .end annotation
.end field

.field private final secretKey:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "SecretAccessKey"
    .end annotation
.end field

.field private final sessionToken:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "SessionToken"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ResponseDate;)V
    .locals 2
    .param p1, "accessKey"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "AccessKeyId"
        .end annotation
    .end param
    .param p2, "secretKey"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "SecretAccessKey"
        .end annotation
    .end param
    .param p3, "sessionToken"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "SessionToken"
        .end annotation
    .end param
    .param p4, "expiration"    # Lio/minio/messages/ResponseDate;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Expiration"
        .end annotation
    .end param

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 51
    const-string v0, "AccessKey must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lio/minio/credentials/Credentials;->accessKey:Ljava/lang/String;

    .line 52
    const-string v0, "SecretKey must not be null"

    invoke-static {p2, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lio/minio/credentials/Credentials;->secretKey:Ljava/lang/String;

    .line 53
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 56
    iput-object p3, p0, Lio/minio/credentials/Credentials;->sessionToken:Ljava/lang/String;

    .line 57
    iput-object p4, p0, Lio/minio/credentials/Credentials;->expiration:Lio/minio/messages/ResponseDate;

    .line 58
    return-void

    .line 54
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "AccessKey and SecretKey must not be empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public accessKey()Ljava/lang/String;
    .locals 1

    .line 61
    iget-object v0, p0, Lio/minio/credentials/Credentials;->accessKey:Ljava/lang/String;

    return-object v0
.end method

.method public isExpired()Z
    .locals 3

    .line 73
    iget-object v0, p0, Lio/minio/credentials/Credentials;->expiration:Lio/minio/messages/ResponseDate;

    if-nez v0, :cond_0

    .line 74
    const/4 v0, 0x0

    return v0

    .line 77
    :cond_0
    invoke-static {}, Ljava/time/ZonedDateTime;->now()Ljava/time/ZonedDateTime;

    move-result-object v0

    const-wide/16 v1, 0xa

    invoke-static {v1, v2}, Ljava/time/Duration;->ofSeconds(J)Ljava/time/Duration;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/time/ZonedDateTime;->plus(Ljava/time/temporal/TemporalAmount;)Ljava/time/ZonedDateTime;

    move-result-object v0

    iget-object v1, p0, Lio/minio/credentials/Credentials;->expiration:Lio/minio/messages/ResponseDate;

    invoke-virtual {v1}, Lio/minio/messages/ResponseDate;->zonedDateTime()Ljava/time/ZonedDateTime;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/time/ZonedDateTime;->isAfter(Ljava/time/chrono/ChronoZonedDateTime;)Z

    move-result v0

    return v0
.end method

.method public secretKey()Ljava/lang/String;
    .locals 1

    .line 65
    iget-object v0, p0, Lio/minio/credentials/Credentials;->secretKey:Ljava/lang/String;

    return-object v0
.end method

.method public sessionToken()Ljava/lang/String;
    .locals 1

    .line 69
    iget-object v0, p0, Lio/minio/credentials/Credentials;->sessionToken:Ljava/lang/String;

    return-object v0
.end method
