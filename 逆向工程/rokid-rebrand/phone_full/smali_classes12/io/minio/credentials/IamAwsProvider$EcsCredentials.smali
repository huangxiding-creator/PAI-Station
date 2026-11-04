.class public Lio/minio/credentials/IamAwsProvider$EcsCredentials;
.super Ljava/lang/Object;
.source "IamAwsProvider.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/credentials/IamAwsProvider;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "EcsCredentials"
.end annotation


# instance fields
.field private accessKey:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
        value = "AccessKeyID"
    .end annotation
.end field

.field private code:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
        value = "Code"
    .end annotation
.end field

.field private expiration:Lio/minio/messages/ResponseDate;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
        value = "Expiration"
    .end annotation
.end field

.field private message:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
        value = "Message"
    .end annotation
.end field

.field private secretKey:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
        value = "SecretAccessKey"
    .end annotation
.end field

.field private sessionToken:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
        value = "Token"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 242
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public code()Ljava/lang/String;
    .locals 1

    .line 262
    iget-object v0, p0, Lio/minio/credentials/IamAwsProvider$EcsCredentials;->code:Ljava/lang/String;

    return-object v0
.end method

.method public message()Ljava/lang/String;
    .locals 1

    .line 266
    iget-object v0, p0, Lio/minio/credentials/IamAwsProvider$EcsCredentials;->message:Ljava/lang/String;

    return-object v0
.end method

.method public toCredentials()Lio/minio/credentials/Credentials;
    .locals 5

    .line 270
    new-instance v0, Lio/minio/credentials/Credentials;

    iget-object v1, p0, Lio/minio/credentials/IamAwsProvider$EcsCredentials;->accessKey:Ljava/lang/String;

    iget-object v2, p0, Lio/minio/credentials/IamAwsProvider$EcsCredentials;->secretKey:Ljava/lang/String;

    iget-object v3, p0, Lio/minio/credentials/IamAwsProvider$EcsCredentials;->sessionToken:Ljava/lang/String;

    iget-object v4, p0, Lio/minio/credentials/IamAwsProvider$EcsCredentials;->expiration:Lio/minio/messages/ResponseDate;

    invoke-direct {v0, v1, v2, v3, v4}, Lio/minio/credentials/Credentials;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ResponseDate;)V

    return-object v0
.end method
