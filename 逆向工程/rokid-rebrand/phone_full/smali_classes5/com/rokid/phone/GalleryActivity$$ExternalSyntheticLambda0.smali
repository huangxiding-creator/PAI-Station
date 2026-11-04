.class public final synthetic Lcom/rokid/phone/GalleryActivity$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# instance fields
.field public final synthetic f$0:Lcom/rokid/phone/GalleryActivity;


# direct methods
.method public synthetic constructor <init>(Lcom/rokid/phone/GalleryActivity;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/phone/GalleryActivity$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/phone/GalleryActivity;

    return-void
.end method


# virtual methods
.method public final invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/rokid/phone/GalleryActivity$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/phone/GalleryActivity;

    check-cast p1, Ljava/io/File;

    invoke-static {v0, p1}, Lcom/rokid/phone/GalleryActivity;->$r8$lambda$XbwWL_3DTLDlbQ8Hl886gJXAMHk(Lcom/rokid/phone/GalleryActivity;Ljava/io/File;)Z

    move-result p1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1
.end method
