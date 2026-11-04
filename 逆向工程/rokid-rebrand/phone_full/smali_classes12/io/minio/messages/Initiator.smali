.class public Lio/minio/messages/Initiator;
.super Ljava/lang/Object;
.source "Initiator.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Initiator"
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

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public displayName()Ljava/lang/String;
    .locals 1

    .line 43
    iget-object v0, p0, Lio/minio/messages/Initiator;->displayName:Ljava/lang/String;

    return-object v0
.end method

.method public id()Ljava/lang/String;
    .locals 1

    .line 38
    iget-object v0, p0, Lio/minio/messages/Initiator;->id:Ljava/lang/String;

    return-object v0
.end method
