.class public Lio/minio/messages/CreateBucketConfiguration;
.super Ljava/lang/Object;
.source "CreateBucketConfiguration.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "CreateBucketConfiguration"
.end annotation


# instance fields
.field private locationConstraint:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "LocationConstraint"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "locationConstraint"    # Ljava/lang/String;

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    iput-object p1, p0, Lio/minio/messages/CreateBucketConfiguration;->locationConstraint:Ljava/lang/String;

    .line 38
    return-void
.end method
