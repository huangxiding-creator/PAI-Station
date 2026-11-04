.class public Lio/minio/messages/RestoreRequest;
.super Ljava/lang/Object;
.source "RestoreRequest.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "RestoreRequest"
.end annotation


# instance fields
.field private days:Ljava/lang/Integer;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Days"
        required = false
    .end annotation
.end field

.field private description:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Description"
        required = false
    .end annotation
.end field

.field private glacierJobParameters:Lio/minio/messages/GlacierJobParameters;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "GlacierJobParameters"
        required = false
    .end annotation
.end field

.field private outputLocation:Lio/minio/messages/OutputLocation;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "OutputLocation"
        required = false
    .end annotation
.end field

.field private selectParameters:Lio/minio/messages/SelectParameters;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "SelectParameters"
        required = false
    .end annotation
.end field

.field private tier:Lio/minio/messages/Tier;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Tier"
        required = false
    .end annotation
.end field

.field private type:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Type"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/Integer;Lio/minio/messages/GlacierJobParameters;Lio/minio/messages/Tier;Ljava/lang/String;Lio/minio/messages/SelectParameters;Lio/minio/messages/OutputLocation;)V
    .locals 1
    .param p1, "days"    # Ljava/lang/Integer;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p2, "glacierJobParameters"    # Lio/minio/messages/GlacierJobParameters;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p3, "tier"    # Lio/minio/messages/Tier;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p4, "description"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p5, "selectParameters"    # Lio/minio/messages/SelectParameters;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p6, "outputLocation"    # Lio/minio/messages/OutputLocation;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 62
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 63
    iput-object p1, p0, Lio/minio/messages/RestoreRequest;->days:Ljava/lang/Integer;

    .line 64
    iput-object p2, p0, Lio/minio/messages/RestoreRequest;->glacierJobParameters:Lio/minio/messages/GlacierJobParameters;

    .line 65
    if-eqz p5, :cond_0

    const-string v0, "SELECT"

    iput-object v0, p0, Lio/minio/messages/RestoreRequest;->type:Ljava/lang/String;

    .line 66
    :cond_0
    iput-object p3, p0, Lio/minio/messages/RestoreRequest;->tier:Lio/minio/messages/Tier;

    .line 67
    iput-object p4, p0, Lio/minio/messages/RestoreRequest;->description:Ljava/lang/String;

    .line 68
    iput-object p5, p0, Lio/minio/messages/RestoreRequest;->selectParameters:Lio/minio/messages/SelectParameters;

    .line 69
    iput-object p6, p0, Lio/minio/messages/RestoreRequest;->outputLocation:Lio/minio/messages/OutputLocation;

    .line 70
    return-void
.end method
