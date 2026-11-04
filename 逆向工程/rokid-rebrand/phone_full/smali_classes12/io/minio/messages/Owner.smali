.class public Lio/minio/messages/Owner;
.super Ljava/lang/Object;
.source "Owner.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Owner"
    strict = false
.end annotation


# instance fields
.field private displayName:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "DisplayName"
        required = false
    .end annotation
.end field

.field private id:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ID"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public displayName()Ljava/lang/String;
    .locals 1

    .line 44
    iget-object v0, p0, Lio/minio/messages/Owner;->displayName:Ljava/lang/String;

    return-object v0
.end method

.method public id()Ljava/lang/String;
    .locals 1

    .line 39
    iget-object v0, p0, Lio/minio/messages/Owner;->id:Ljava/lang/String;

    return-object v0
.end method
