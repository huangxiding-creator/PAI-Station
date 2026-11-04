.class public Lio/minio/messages/VersioningConfiguration;
.super Ljava/lang/Object;
.source "VersioningConfiguration.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/messages/VersioningConfiguration$Status;
    }
.end annotation

.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "VersioningConfiguration"
    strict = false
.end annotation


# instance fields
.field private mfaDelete:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "MFADelete"
        required = false
    .end annotation
.end field

.field private status:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Status"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Lio/minio/messages/VersioningConfiguration$Status;Ljava/lang/Boolean;)V
    .locals 2
    .param p1, "status"    # Lio/minio/messages/VersioningConfiguration$Status;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "mfaDelete"    # Ljava/lang/Boolean;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    const-string v0, "Status must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    .line 49
    sget-object v0, Lio/minio/messages/VersioningConfiguration$Status;->OFF:Lio/minio/messages/VersioningConfiguration$Status;

    if-eq p1, v0, :cond_2

    .line 52
    invoke-virtual {p1}, Lio/minio/messages/VersioningConfiguration$Status;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lio/minio/messages/VersioningConfiguration;->status:Ljava/lang/String;

    .line 54
    if-eqz p2, :cond_1

    .line 55
    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "Enabled"

    goto :goto_0

    :cond_0
    const-string v0, "Disabled"

    :goto_0
    iput-object v0, p0, Lio/minio/messages/VersioningConfiguration;->mfaDelete:Ljava/lang/String;

    .line 57
    :cond_1
    return-void

    .line 50
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Status must be ENABLED or SUSPENDED"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public isMfaDeleteEnabled()Ljava/lang/Boolean;
    .locals 2

    .line 64
    iget-object v0, p0, Lio/minio/messages/VersioningConfiguration;->mfaDelete:Ljava/lang/String;

    if-eqz v0, :cond_0

    const-string v0, "Enabled"

    iget-object v1, p0, Lio/minio/messages/VersioningConfiguration;->mfaDelete:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 65
    .local v0, "flag":Ljava/lang/Boolean;
    :goto_0
    return-object v0
.end method

.method public status()Lio/minio/messages/VersioningConfiguration$Status;
    .locals 1

    .line 60
    iget-object v0, p0, Lio/minio/messages/VersioningConfiguration;->status:Ljava/lang/String;

    invoke-static {v0}, Lio/minio/messages/VersioningConfiguration$Status;->fromString(Ljava/lang/String;)Lio/minio/messages/VersioningConfiguration$Status;

    move-result-object v0

    return-object v0
.end method
