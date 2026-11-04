.class public Lio/minio/messages/LocationConstraint;
.super Ljava/lang/Object;
.source "LocationConstraint.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "LocationConstraint"
    strict = false
.end annotation


# instance fields
.field private location:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Text;
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    const-string v0, ""

    iput-object v0, p0, Lio/minio/messages/LocationConstraint;->location:Ljava/lang/String;

    .line 34
    return-void
.end method


# virtual methods
.method public location()Ljava/lang/String;
    .locals 1

    .line 37
    iget-object v0, p0, Lio/minio/messages/LocationConstraint;->location:Ljava/lang/String;

    return-object v0
.end method
