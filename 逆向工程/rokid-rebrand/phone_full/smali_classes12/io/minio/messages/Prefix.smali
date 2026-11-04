.class public Lio/minio/messages/Prefix;
.super Ljava/lang/Object;
.source "Prefix.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "CommonPrefixes"
    strict = false
.end annotation


# instance fields
.field private prefix:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Prefix"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public toItem()Lio/minio/messages/Item;
    .locals 2

    .line 34
    new-instance v0, Lio/minio/messages/Contents;

    iget-object v1, p0, Lio/minio/messages/Prefix;->prefix:Ljava/lang/String;

    invoke-direct {v0, v1}, Lio/minio/messages/Contents;-><init>(Ljava/lang/String;)V

    return-object v0
.end method
