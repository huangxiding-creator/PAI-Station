.class public Lio/minio/messages/JsonInputSerialization;
.super Ljava/lang/Object;
.source "JsonInputSerialization.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "JSON"
.end annotation


# instance fields
.field private type:Lio/minio/messages/JsonType;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Type"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/JsonType;)V
    .locals 0
    .param p1, "type"    # Lio/minio/messages/JsonType;

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    iput-object p1, p0, Lio/minio/messages/JsonInputSerialization;->type:Lio/minio/messages/JsonType;

    .line 35
    return-void
.end method
